import 'package:flutter/material.dart';
import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});
  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final titleCtrl = TextEditingController();
  final timeCtrl = TextEditingController();
  TimeOfDay? time;

  Future<void> pickTime() async {
    final t = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (t == null) return;
    setState(() {
      time = t;
      timeCtrl.text = t.format(context);
    });
  }

  void save() {
    final title = titleCtrl.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Hãy nhập tên nhiệm vụ')));
      return;
    }
    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch % 2000000000,
      title: title,
      hour: time?.hour,
      minute: time?.minute,
    );
    Navigator.pop(context, task); // trả về màn hình chính
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thêm nhiệm vụ mới')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(
                  labelText: 'Tên nhiệm vụ', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: timeCtrl,
              readOnly: true,
              onTap: pickTime,
              decoration: const InputDecoration(
                  labelText: 'Giờ nhắc', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: save, child: const Text('Lưu nhiệm vụ')),
          ],
        ),
      ),
    );
  }
}
