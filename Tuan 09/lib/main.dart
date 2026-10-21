import 'package:flutter/material.dart';
import 'tai_lop/views/task_screen.dart';
import 'tai_lop/views/student_screen.dart';
import 've_nha/views/expense_screen.dart';
import 've_nha/views/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Bài 09 - SQLite',
    theme: ThemeData(useMaterial3: true),
    home: const HomeScreen(),
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _open(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute<void>(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Bài 09 - SQLite')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Bài tập thực hành tại lớp',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ListTile(
          title: const Text('Bài 1'),
          onTap: () => _open(context, const TaskScreen()),
        ),
        ListTile(
          title: const Text('Bài 2'),
          onTap: () => _open(context, const StudentScreen()),
        ),
        const Divider(),
        const SizedBox(height: 16),
        const Text('Bài tập về nhà',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ListTile(
          title: const Text('Bài 1'),
          onTap: () => _open(context, const ExpenseScreen()),
        ),
        ListTile(
          title: const Text('Bài 2'),
          onTap: () => _open(context, const LoginScreen()),
        ),
      ],
    ),
  );
}
