import 'package:flutter/material.dart';
import 'services/notification_service.dart';
import 'views/screen_noti_ex.dart';
import 'views/screen_todo.dart';
import 'views/task_list_screen.dart';
import 'views/vocab_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white, useMaterial3: true),
      home: const HomeMenu(),
    );
  }
}

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <(String, Widget)>[
      ('Bài 1: Notification cơ bản', const ScreenNotiEx()),
      ('Bài 2 + 3: Todo App (file + notification)', const ScreenTodo()),
      ('Bài 4: Ứng dụng học từ vựng', const VocabHome()),
      ('Bài tập về nhà: Nhiệm vụ mỗi ngày', const TaskListScreen()),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Lab 8 - Notification & File')),
      body: ListView(
        children: [
          for (final it in items)
            ListTile(
              title: Text(it.$1),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => it.$2),
              ),
            ),
        ],
      ),
    );
  }
}