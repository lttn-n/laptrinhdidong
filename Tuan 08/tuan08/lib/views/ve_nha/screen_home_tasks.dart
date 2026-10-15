import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/home_task.dart';
import '../../services/home_task_service.dart';
import '../../services/notification_service.dart';

class ScreenHomeTasks extends StatefulWidget {
  const ScreenHomeTasks({super.key});
  @override State<ScreenHomeTasks> createState()=>_ScreenHomeTasksState();
}
class _ScreenHomeTasksState extends State<ScreenHomeTasks> {
  List<HomeTask> tasks=[];
  final fileService=HomeTaskService();
  final notificationService=NotificationService();
  @override void initState(){super.initState();loadData();}
  Future<void> loadData() async {final data=await fileService.loadTasks();if(mounted)setState(()=>tasks=data);}
  int get completedCount=>tasks.where((e)=>e.completed).length;
  Future<void> addTask() async {
    final result=await Navigator.push<HomeTask>(context,MaterialPageRoute(builder:(context)=>const ScreenAddTask()));
    if(result==null||!mounted)return;
    tasks.add(result);
    await fileService.saveTasks(tasks);
    if(result.time!=null){
      try {await notificationService.scheduleNotificationAt(id:result.id,title:'Nhắc nhiệm vụ',body:result.title,scheduledTime:result.time!);}
      catch(e){if(mounted)ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Đã lưu nhiệm vụ nhưng chưa hẹn được thông báo: $e')));}
    }
    if(mounted)setState((){});
  }
  Future<void> completeTask(int index) async {
    if(tasks[index].completed)return;
    final confirm=await showDialog<bool>(context:context,builder:(dialogContext)=>AlertDialog(title:const Text('Xác nhận'),content:const Text('Bạn có xác nhận nhiệm vụ này đã hoàn thành?'),actions:[
      TextButton(onPressed:()=>Navigator.pop(dialogContext,false),child:const Text('Không')),
      TextButton(onPressed:()=>Navigator.pop(dialogContext,true),child:const Text('Có'))]));
    if(confirm!=true||!mounted)return;
    tasks[index].completed=true;
    await fileService.saveTasks(tasks);
    await notificationService.cancelNotification(tasks[index].id);
    await notificationService.showSimpleNotification(id:notificationService.nextId(),title:'Hoàn thành nhiệm vụ',body:'Đã hoàn thành $completedCount nhiệm vụ');
    if(mounted)setState((){});
  }
  @override Widget build(BuildContext context)=>Scaffold(
    appBar:AppBar(title:const Text('TodoList'),centerTitle:true),
    body:Column(children:[
      Padding(padding:const EdgeInsets.all(16),child:Text('Đã hoàn thành: $completedCount/${tasks.length}',style:const TextStyle(fontSize:18,fontWeight:FontWeight.bold))),
      Expanded(child:tasks.isEmpty?const Center(child:Text('Chưa có nhiệm vụ nào')):ListView.builder(itemCount:tasks.length,itemBuilder:(context,index){
        final task=tasks[index];return Card(margin:const EdgeInsets.symmetric(horizontal:15,vertical:5),child:CheckboxListTile(
          value:task.completed,onChanged:(value){if(value==true)completeTask(index);},
          title:Text(task.title,style:TextStyle(decoration:task.completed?TextDecoration.lineThrough:null)),
          subtitle:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(task.content),if(task.time!=null)Text(DateFormat('dd/MM/yyyy HH:mm').format(task.time!))]),
          secondary:Icon(task.completed?Icons.check_circle:Icons.notifications_active,color:task.completed?Colors.green:Colors.blue)));
      }))]),floatingActionButton:FloatingActionButton(onPressed:addTask,child:const Icon(Icons.add)));
}

class ScreenAddTask extends StatefulWidget {
  const ScreenAddTask({super.key});
  @override State<ScreenAddTask> createState()=>_ScreenAddTaskState();
}
class _ScreenAddTaskState extends State<ScreenAddTask> {
  final titleController=TextEditingController();
  final contentController=TextEditingController();
  DateTime? selectedTime;
  Future<void> pickDateTime() async {
    final date=await showDatePicker(context:context,initialDate:DateTime.now(),firstDate:DateTime.now(),lastDate:DateTime(2100));
    if(date==null||!mounted)return;
    final time=await showTimePicker(context:context,initialTime:TimeOfDay.now());
    if(time==null||!mounted)return;
    setState(()=>selectedTime=DateTime(date.year,date.month,date.day,time.hour,time.minute));
  }
  void saveTask(){
    if(titleController.text.trim().isEmpty){ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Vui lòng nhập tên nhiệm vụ')));return;}
    if(selectedTime!=null&&!selectedTime!.isAfter(DateTime.now())){ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Thời gian thông báo phải ở tương lai')));return;}
    final task=HomeTask(id:DateTime.now().microsecondsSinceEpoch.remainder(2147483647),title:titleController.text.trim(),content:contentController.text.trim(),time:selectedTime);
    Navigator.pop(context,task);
  }
  @override void dispose(){titleController.dispose();contentController.dispose();super.dispose();}
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Thêm nhiệm vụ')),
    body:Padding(padding:const EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[
      TextField(controller:titleController,decoration:const InputDecoration(labelText:'Tên nhiệm vụ',border:OutlineInputBorder())),
      const SizedBox(height:15),
      TextField(controller:contentController,maxLines:3,decoration:const InputDecoration(labelText:'Nội dung',border:OutlineInputBorder())),
      const SizedBox(height:20),
      Row(children:[IconButton(icon:const Icon(Icons.notifications,color:Colors.blue),onPressed:pickDateTime),
        Expanded(child:Text(selectedTime==null?'Chưa đặt lịch nhắc':DateFormat('dd/MM/yyyy HH:mm').format(selectedTime!)))]),
      const SizedBox(height:20),ElevatedButton(onPressed:saveTask,child:const Text('Lưu nhiệm vụ'))])));
}
