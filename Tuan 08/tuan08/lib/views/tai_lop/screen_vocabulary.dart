import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import '../../models/vocabulary.dart';
import '../../services/vocabulary_service.dart';
import '../../services/notification_service.dart';

class ScreenVocabulary extends StatefulWidget {
  const ScreenVocabulary({super.key});
  @override State<ScreenVocabulary> createState() => _ScreenVocabularyState();
}
class _ScreenVocabularyState extends State<ScreenVocabulary> {
  final wordController = TextEditingController();
  final meaningController = TextEditingController();
  final answerController = TextEditingController();
  final vocabularyService = VocabularyService();
  final notificationService = NotificationService();
  List<Vocabulary> words=[];
  int page=0, currentIndex=0, correct=0, wrong=0, testCorrect=0, testWrong=0;
  @override void initState() {super.initState();loadData();}
  Future<void> loadData() async {final data=await vocabularyService.loadWords();if(mounted)setState(()=>words=data);}
  Future<void> saveWord() async {
    final word=wordController.text.trim(); final meaning=meaningController.text.trim();
    if(word.isEmpty || meaning.isEmpty) {showSnack('Vui lòng nhập từ và nghĩa');return;}
    if(word.contains('|') || word.contains('\n') || meaning.contains('\n')) {showSnack('Không dùng ký tự | hoặc xuống dòng');return;}
    words.add(Vocabulary(word:word,meaning:meaning));
    await vocabularyService.saveWords(words);
    await notificationService.showSimpleNotification(id:notificationService.nextId(),title:'Đã lưu từ vựng',body:'Hãy ôn tập từ $word sau 10 phút');
    try {
      await notificationService.scheduleNotificationAfter(const Duration(minutes:10),'vocabulary_channel','Nhắc học từ vựng','Đến giờ ôn tập từ: $word');
    } catch (e) {showSnack('Đã lưu từ nhưng chưa đặt được lịch: $e');}
    wordController.clear();meaningController.clear();
    if(!mounted)return;setState((){});showSnack('Đã lưu từ và đặt nhắc học sau 10 phút');
  }
  void showSnack(String text,{Color? color}) {if(!mounted)return;ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor:color,content:Text(text)));}
  bool checkAnswer() => answerController.text.trim().toLowerCase()==words[currentIndex].meaning.trim().toLowerCase();
  Future<void> checkWord() async {
    if(words.isEmpty || answerController.text.trim().isEmpty)return;
    final ok=checkAnswer();final meaning=words[currentIndex].meaning;
    if(ok){correct++;}else{wrong++;if(wrong%3==0){await notificationService.showSimpleNotification(id:notificationService.nextId(),title:'Nhắc ôn tập',body:'Bạn đã trả lời sai $wrong từ. Hãy ôn tập thêm!');}}
    if(!mounted)return;
    showSnack(ok?'Chính xác!':'Sai rồi! Đáp án: $meaning',color:ok?Colors.green:Colors.red);
    answerController.clear();setState(()=>currentIndex=(currentIndex+1)%words.length);
  }
  void checkTest(){
    if(words.isEmpty || answerController.text.trim().isEmpty)return;
    if(checkAnswer()){testCorrect++;}else{testWrong++;}
    answerController.clear();
    if(currentIndex<words.length-1){setState(()=>currentIndex++);}else{
      final total=testCorrect+testWrong;
      final percent=total==0?0.0:testCorrect*100/total;
      showDialog<void>(context:context,builder:(dialogContext)=>AlertDialog(title:const Text('Kết quả kiểm tra'),content:Text('Số câu đúng: $testCorrect\nSố câu sai: $testWrong\nTỉ lệ đúng: ${percent.toStringAsFixed(2)}%'),actions:[TextButton(onPressed:(){Navigator.pop(dialogContext);setState((){page=0;currentIndex=0;testCorrect=0;testWrong=0;});},child:const Text('Đóng'))]));
    }
  }
  void changePage(int value){Navigator.pop(context);setState((){page=value;currentIndex=0;answerController.clear();if(value==2){testCorrect=0;testWrong=0;}});}
  Widget homePage()=>Padding(padding:const EdgeInsets.all(16),child:Column(children:[
    TextField(controller:wordController,decoration:const InputDecoration(labelText:'Từ')),
    const SizedBox(height:10),TextField(controller:meaningController,decoration:const InputDecoration(labelText:'Nghĩa')),
    const SizedBox(height:20),ElevatedButton(onPressed:saveWord,child:const Text('Lưu & Nhắc học sau 10 phút'))]));
  Widget studyPage(bool isTest){
    if(words.isEmpty)return const Center(child:Text('Chưa có từ vựng nào'));
    final vocab=words[currentIndex];
    return Padding(padding:const EdgeInsets.all(16),child:Column(children:[
      Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,children:[
        Container(padding:const EdgeInsets.all(12),color:Colors.green,child:Text('✓ ${isTest?testCorrect:correct} từ',style:const TextStyle(color:Colors.white))),
        Container(padding:const EdgeInsets.all(12),color:Colors.orange,child:Text('✕ ${isTest?testWrong:wrong} từ',style:const TextStyle(color:Colors.white)))]),
      const SizedBox(height:30),
      Container(padding:const EdgeInsets.all(20),decoration:BoxDecoration(color:Colors.blue.shade100,borderRadius:BorderRadius.circular(15)),child:Column(children:[
        Text(vocab.word,style:const TextStyle(fontSize:20,fontWeight:FontWeight.bold)),const SizedBox(height:15),
        TextField(controller:answerController,decoration:const InputDecoration(hintText:'Nhập nghĩa tiếng Việt',border:OutlineInputBorder(),filled:true,fillColor:Colors.white)),
        const SizedBox(height:15),ElevatedButton(onPressed:isTest?checkTest:checkWord,child:const Text('Check'))])),
      if(isTest)Padding(padding:const EdgeInsets.all(15),child:Text('Câu ${currentIndex+1}/${words.length}'))]));
  }
  Widget reminderPage()=>FutureBuilder<List<PendingNotificationRequest>>(
    future:notificationService.getPendingNotifications(),
    builder:(context,snapshot){
      if(snapshot.hasError)return Center(child:Text('Không thể tải lịch nhắc: ${snapshot.error}'));
      if(!snapshot.hasData)return const Center(child:CircularProgressIndicator());
      final reminders=snapshot.data!.where((e)=>e.title=='Nhắc học từ vựng').toList();
      if(reminders.isEmpty)return const Center(child:Text('Chưa có lịch nhắc từ vựng'));
      return ListView.builder(itemCount:reminders.length,itemBuilder:(context,index){final r=reminders[index];return Card(child:ListTile(leading:const Icon(Icons.notifications),title:Text(r.title??''),subtitle:Text(r.body??'')));});
    });
  @override void dispose(){wordController.dispose();meaningController.dispose();answerController.dispose();super.dispose();}
  @override Widget build(BuildContext context) => Scaffold(
    appBar:AppBar(title:Text(['Ứng dụng học từ vựng','Ôn tập từ mới','Kiểm tra từ','Lịch nhắc'][page])),
    drawer:Drawer(child:ListView(children:[
      const UserAccountsDrawerHeader(accountName:Text('Trợ lý học từ vựng'),accountEmail:Text(''),currentAccountPicture:CircleAvatar(child:Icon(Icons.menu_book))),
      ListTile(leading:const Icon(Icons.home),title:const Text('Trang chính'),onTap:()=>changePage(0)),
      ListTile(leading:const Icon(Icons.list),title:const Text('Học từ'),onTap:()=>changePage(1)),
      ListTile(leading:const Icon(Icons.quiz),title:const Text('Kiểm tra từ'),onTap:()=>changePage(2)),
      ListTile(leading:const Icon(Icons.notifications),title:const Text('Lịch nhắc'),onTap:()=>changePage(3))])),
    body:page==0?homePage():page==1?studyPage(false):page==2?studyPage(true):reminderPage());
}
