import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/todo.dart';
import '../../services/file_services.dart';
import '../../services/notification_service.dart';
class ScreenTodo extends StatefulWidget {
  final bool enableReminder;
  const ScreenTodo({super.key, this.enableReminder = false});
  @override
  State<ScreenTodo> createState() => _TodoScreenState();
}
class _TodoScreenState extends State<ScreenTodo> {
  final controller = TextEditingController();
  final fileService = FileService();
  final notificationService = NotificationService();
  List<Todo> todos = [];
  DateTime? selectedTime;
  @override
  void initState() { super.initState(); loadData(); }
  Future<void> loadData() async { final data = await fileService.loadTodos(); if (!mounted) return; setState(() => todos = data); }
  Future<void> addTodo() async {
    if (controller.text.trim().isEmpty || selectedTime == null) return;
    if (widget.enableReminder && !selectedTime!.isAfter(DateTime.now())) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Vui lòng chọn thời gian tương lai'))); return;
    }
    final todo = Todo(title: controller.text.trim(), time: selectedTime!);
    todos.add(todo);
    await fileService.saveTodos(todos);
    if (widget.enableReminder) {
      final id = notificationService.nextId();
      await notificationService.showSimpleNotification(id: id, title: 'Đã thêm lịch', body: 'Đã đặt lịch cho ${todo.title}');
      try {
        await notificationService.scheduleNotificationAt(id: (id+1) % 2147483647, title: 'Nhắc công việc', body: 'Đến giờ thực hiện: ${todo.title}', scheduledTime: todo.time);
      } catch (e) {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Đã lưu công việc nhưng chưa hẹn được thông báo: $e')));
      }
    }
    controller.clear(); selectedTime = null;
    if (mounted) setState(() {});
  }
  Future<void> pickDateTime() async {
    final date = await showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime(2100), initialDate: DateTime.now());
    if (date == null || !mounted) return;
    final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time == null || !mounted) return;
    setState(() => selectedTime = DateTime(date.year,date.month,date.day,time.hour,time.minute));
  }
  String formatTime(DateTime time) => DateFormat('dd/MM/yyyy HH:mm').format(time);
  @override void dispose() { controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    final colors = [Colors.red.shade100,Colors.green.shade100,Colors.blue.shade100,Colors.yellow.shade100,Colors.purple.shade100];
    Color getTextColor(Color bg) => bg.computeLuminance() > .5 ? Colors.black87 : Colors.white;
    return Scaffold(appBar: AppBar(title: const Text('Todo App'), centerTitle:true),
      body: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
        TextField(controller: controller, decoration: InputDecoration(labelText:'Tên công việc',filled:true,fillColor:Colors.white,
          enabledBorder:OutlineInputBorder(borderSide:const BorderSide(color:Colors.blue,width:1.5),borderRadius:BorderRadius.circular(10)),
          focusedBorder:OutlineInputBorder(borderSide:const BorderSide(color:Colors.blue,width:2),borderRadius:BorderRadius.circular(10)),
          border:OutlineInputBorder(borderRadius:BorderRadius.circular(10)))),
        const SizedBox(height:10),
        Row(children:[Expanded(child:Text(selectedTime == null ? 'Chưa chọn thời gian' : formatTime(selectedTime!))),
          ElevatedButton(onPressed:pickDateTime,style:ElevatedButton.styleFrom(backgroundColor:Colors.white,foregroundColor:Colors.blue,side:const BorderSide(color:Colors.blue,width:1.5),elevation:0,padding:const EdgeInsets.symmetric(horizontal:20,vertical:12),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(25))),child:const Text('Chọn thời gian',style:TextStyle(fontWeight:FontWeight.w600)))]),
        const SizedBox(height:10),
        ElevatedButton(onPressed:addTodo,style:ElevatedButton.styleFrom(backgroundColor:Colors.blue,foregroundColor:Colors.white,side:const BorderSide(color:Colors.blue,width:1.5),elevation:0,padding:const EdgeInsets.symmetric(horizontal:20,vertical:12),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(25))),child:const Text('Lưu')),
        const SizedBox(height:20),
        Expanded(child:ListView.builder(itemCount:todos.length,itemBuilder:(context,index){
          final t=todos[index]; final bg=colors[index%colors.length];
          return Card(color:bg,child:ListTile(leading:Icon(Icons.task,color:getTextColor(bg)),title:Text(t.title,style:TextStyle(color:getTextColor(bg),fontWeight:FontWeight.bold)),subtitle:Text(formatTime(t.time),style:TextStyle(color:getTextColor(bg).withOpacity(.7)))));
        }))
      ])));
  }
}
