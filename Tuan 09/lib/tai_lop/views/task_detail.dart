import 'package:flutter/material.dart';
import '../models/task.dart';
import '../controllers/task_controller.dart';
import '../utils/ui_helpers.dart';
class TaskDetail extends StatefulWidget {
 final Task task;
 const TaskDetail({super.key, required this.task});
 @override
 State<TaskDetail> createState() => _TaskDetailState();
}
class _TaskDetailState extends State<TaskDetail> {
 bool _saving = false;
 Future<void> _change(bool? value) async {
  if (value == null || _saving) return;
  setState(() => _saving = true);
  try {
   await TaskController().updateTask(Task(id: widget.task.id, title: widget.task.title,
    description: widget.task.description, isCompleted: value));
   if (mounted) Navigator.pop(context, true);
  } catch (_) {
   if (mounted) { setState(() => _saving = false); notify(context, 'Không thể cập nhật trạng thái');
   }
  }
 }
 @override
 Widget build(BuildContext context) => Scaffold(
  appBar: AppBar(title: const Text('Task Details')),
  body: Padding(padding: const EdgeInsets.all(20), child: Column(
   crossAxisAlignment: CrossAxisAlignment.start,
   children: [
    const Text('Title', style: TextStyle(fontWeight: FontWeight.bold)),
    Text(widget.task.title), const SizedBox(height: 20),
    const Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
    Text(widget.task.description), const SizedBox(height: 20),
    Row(children: [const Text('Completed'), Checkbox(value: widget.task.isCompleted,
     onChanged: _saving ? null : _change)]),
    if (_saving) const LinearProgressIndicator(),
   ],
  )),
 );
}
