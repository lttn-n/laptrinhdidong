import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/file_service.dart';
import '../services/notification_service.dart';
import 'add_task_screen.dart';

/// BÀI TẬP VỀ NHÀ - Nhiệm vụ mỗi ngày
class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});
  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final file = FileService('tasks.txt');
  final noti = NotificationService.instance;
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final list = <Task>[];
    for (final l in await file.readLines()) {
      try {
        list.add(Task.fromString(l));
      } catch (_) {}
    }
    setState(() => tasks = list);
  }

  Future<void> _save() => file.writeLines(tasks.map((e) => e.toFileString()).toList());

  /// đặt thông báo lặp lại mỗi ngày vào giờ đã chọn
  Future<void> _scheduleDaily(Task t) async {
    if (t.hour == null) return;
    final now = DateTime.now();
    await noti.schedule(
      id: t.id,
      title: 'Nhiệm vụ mỗi ngày',
      body: t.title,
      time: DateTime(now.year, now.month, now.day, t.hour!, t.minute!),
      channelId: 'daily_task_channel',
      channelName: 'Nhiệm vụ mỗi ngày',
      daily: true,
    );
  }

  Future<void> _addTask() async {
    final task = await Navigator.push<Task>(
      context,
      MaterialPageRoute(builder: (_) => const AddTaskScreen()),
    );
    if (task == null) return;
    tasks.add(task);
    await _save();
    await _scheduleDaily(task);
    setState(() {});
  }

  Future<void> _pickReminder(Task t) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: t.hour ?? 20, minute: t.minute ?? 0),
    );
    if (picked == null) return;
    t.hour = picked.hour;
    t.minute = picked.minute;
    await _save();
    await _scheduleDaily(t);
    if (!mounted) return;
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đã đặt ${t.reminderText.toLowerCase()}')),
    );
  }

  Future<void> _toggle(Task t, bool? value) async {
    if (value != true) return;
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Xác nhận'),
        content: Text('Bạn xác nhận nhiệm vụ "${t.title}" đã hoàn thành?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Không')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Có')),
        ],
      ),
    );
    if (ok != true) return;
    t.done = true;
    await _save();
    await noti.cancel(t.id); // hủy nhắc của việc đã xong
    final count = tasks.where((e) => e.done).length;
    await noti.show(
      id: 9999,
      title: 'Hoàn thành nhiệm vụ',
      body: 'Bạn đã hoàn thành $count nhiệm vụ',
      channelId: 'done_channel',
      channelName: 'Hoàn thành',
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nhiệm vụ mỗi ngày'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today_outlined),
            onPressed: () => showDatePicker(
              context: context,
              firstDate: DateTime(2020),
              lastDate: DateTime(2100),
              initialDate: DateTime.now(),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: tasks.length,
        itemBuilder: (_, i) {
          final t = tasks[i];
          return Card(
            child: ListTile(
              leading: Checkbox(value: t.done, onChanged: t.done ? null : (v) => _toggle(t, v)),
              title: Text(
                t.title,
                style: TextStyle(
                  decoration: t.done ? TextDecoration.lineThrough : null,
                ),
              ),
              subtitle: Text(t.reminderText),
              trailing: IconButton(
                icon: Icon(t.hour == null
                    ? Icons.notifications_none
                    : Icons.notifications_active),
                onPressed: () => _pickReminder(t),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
