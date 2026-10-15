import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/todo.dart';
import '../services/file_service.dart';
import '../services/notification_service.dart';

class ScreenTodo extends StatefulWidget {
  const ScreenTodo({super.key});
  @override
  State<ScreenTodo> createState() => _ScreenTodoState();
}

class _ScreenTodoState extends State<ScreenTodo> {
  final controller = TextEditingController();
  final fileService = FileService('todo.txt');
  final noti = NotificationService.instance;
  List<Todo> todos = [];
  DateTime? selectedTime;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final lines = await fileService.readLines();
    final list = <Todo>[];
    for (final l in lines) {
      try {
        list.add(Todo.fromString(l));
      } catch (_) {}
    }
    setState(() => todos = list);
  }

  void snack(String msg) => ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(msg)));

  Future<void> addTodo() async {
    final title = controller.text.trim();
    if (title.isEmpty || selectedTime == null) {
      snack('Hãy nhập tên công việc và chọn thời gian');
      return;
    }
    if (!selectedTime!.isAfter(DateTime.now())) {
      snack('Thời gian đã qua, hãy chọn lại');
      return;
    }
    final id = DateTime.now().millisecondsSinceEpoch % 2000000000;
    final todo = Todo(id: id, title: title, time: selectedTime!);
    todos.add(todo);
    await fileService.writeLines(todos.map((e) => e.toFileString()).toList());

    // ---- Bài 3 ----
    // 1) thông báo ngay: đã thêm lịch
    await noti.show(
      id: id + 1,
      title: 'Đã thêm lịch công việc',
      body: '$title - ${formatTime(todo.time)}',
      channelId: 'todo_channel',
      channelName: 'Công việc',
    );
    // 2) đặt lịch nhắc đúng thời gian đã chọn
    await noti.schedule(
      id: id,
      title: 'Đến giờ làm việc',
      body: title,
      time: todo.time,
      channelId: 'todo_channel',
      channelName: 'Công việc',
    );

    controller.clear();
    selectedTime = null;
    if (mounted) setState(() {});
  }

  Future<void> pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time == null) return;
    setState(() => selectedTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute));
  }

  String formatTime(DateTime t) => DateFormat('dd/MM/yyyy HH:mm').format(t);

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.red.shade100,
      Colors.green.shade100,
      Colors.blue.shade100,
      Colors.yellow.shade100,
      Colors.purple.shade100,
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Todo App'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Tên công việc',
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(selectedTime == null
                      ? 'Chưa chọn thời gian'
                      : formatTime(selectedTime!)),
                ),
                OutlinedButton(
                  onPressed: pickDateTime,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.blue, width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                  child: const Text('Chọn thời gian'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: addTodo,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              ),
              child: const Text('Lưu'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, i) {
                  final t = todos[i];
                  return Card(
                    color: colors[i % colors.length],
                    child: ListTile(
                      leading: const Icon(Icons.task, color: Colors.black87),
                      title: Text(t.title,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(formatTime(t.time)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
