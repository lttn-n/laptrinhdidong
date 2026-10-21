import 'package:flutter/material.dart';
import '../models/task.dart';
import '../controllers/task_controller.dart';
import '../utils/ui_helpers.dart';
import 'task_detail.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TaskController _taskController = TaskController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final _form = GlobalKey<FormState>();
  List<Task> _tasks = [];
  bool _loading = true;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    try {
      final tasks = await _taskController.fetchTasks();
      if (mounted) {
        setState(() {
          _tasks = tasks;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _loading = false);
        notify(context, 'Không thể tải công việc. Hãy thử lại.');
      }
    }
  }

  Future<void> _addTask() async {
    if (_busy || !_form.currentState!.validate()) return;
    setState(() => _busy = true);
    try {
      await _taskController.insertTask(Task(
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
      ));
      if (!mounted) return;
      titleController.clear();
      descriptionController.clear();
      await _fetchTasks();
    } catch (_) {
      if (mounted) notify(context, 'Không thể thêm công việc');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _deleteTask() async {
    if (_busy || _tasks.isEmpty) return;
    setState(() => _busy = true);
    try {
      await _taskController.deleteTask(_tasks.last.id!);
      if (!mounted) return;
      titleController.clear();
      descriptionController.clear();
      await _fetchTasks();
    } catch (_) {
      if (mounted) notify(context, 'Không thể xóa công việc');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _openTaskDetail(Task task) async {
    final changed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => TaskDetail(task: task)),
    );
    if (mounted && changed == true) await _fetchTasks();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Task List'),
      actions: [
        IconButton(
          onPressed: _busy ? null : _fetchTasks,
          tooltip: 'Tải lại',
          icon: const Icon(Icons.refresh),
        ),
      ],
    ),
    body: CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 15, 16, 8),
            child: Form(
              key: _form,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    validator: requiredText,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: descriptionController,
                    validator: requiredText,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed:
                          _busy || _loading ? null : _addTask,
                          child: const Text('Add Task'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _busy || _tasks.isEmpty
                              ? null
                              : _deleteTask,
                          child: const Text('Delete Task'),
                        ),
                      ),
                    ],
                  ),
                  if (_busy) const LinearProgressIndicator(),
                ],
              ),
            ),
          ),
        ),
        if (_loading)
          const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: CircularProgressIndicator()),
          )
        else if (_tasks.isEmpty)
          const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text(
                'Chưa có công việc. Nhập thông tin rồi nhấn Add Task.',
              ),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final task = _tasks[index];
                  return Card(
                    color: task.isCompleted
                        ? Colors.green.shade100
                        : Colors.white,
                    elevation: 2,
                    child: ListTile(
                      title: Text(task.title),
                      subtitle: Text(task.description),
                      onTap: _busy
                          ? null
                          : () {
                        titleController.text = task.title;
                        descriptionController.text =
                            task.description;
                      },
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        tooltip: 'Cập nhật trạng thái',
                        onPressed:
                        _busy ? null : () => _openTaskDetail(task),
                      ),
                    ),
                  );
                },
                childCount: _tasks.length,
              ),
            ),
          ),
      ],
    ),
  );
}