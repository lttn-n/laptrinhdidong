import 'package:flutter/material.dart';
import 'services/notification_service.dart';
import 'views/huong_dan/scren_noti_ex.dart';
import 'views/huong_dan/screen_todo.dart';
import 'views/tai_lop/screen_todo_reminder.dart';
import 'views/tai_lop/screen_vocabulary.dart';
import 'views/ve_nha/screen_home_tasks.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override Widget build(BuildContext context)=>MaterialApp(debugShowCheckedModeBanner:false,
    theme:ThemeData(scaffoldBackgroundColor:Colors.white),home:const HomeScreen());
}
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override Widget build(BuildContext context)=>Scaffold(
    appBar:AppBar(title:const Text('Bài 08 - Notification và File'),centerTitle:true),
    body:Padding(padding:const EdgeInsets.all(16),child:ListView(children:[
      const Text('BÀI TẬP HƯỚNG DẪN',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold)),
      const SizedBox(height:10),
      _nav(context,'Bài 1 - Notification',const ScreenNotiEx()),
      const SizedBox(height:10),
      _nav(context,'Bài 2 - Todo App',const ScreenTodo()),
      const SizedBox(height:30),
      const Text('BÀI TẬP TẠI LỚP',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold)),
      const SizedBox(height:10),
      _nav(context,'Bài 3 - Nhắc việc',const ScreenTodoReminder()),
      const SizedBox(height:10),
      _nav(context,'Bài 4 - Học từ vựng',const ScreenVocabulary()),
      const SizedBox(height:30),
      const Text('BÀI TẬP VỀ NHÀ',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold)),
      const SizedBox(height:10),
      _nav(context,'TodoList - Quản lý nhiệm vụ',const ScreenHomeTasks()),
    ])));
  Widget _nav(BuildContext context,String title,Widget screen)=>ElevatedButton(onPressed:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>screen)),child:Text(title));
}
