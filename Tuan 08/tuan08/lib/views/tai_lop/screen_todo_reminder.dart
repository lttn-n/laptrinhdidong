import 'package:flutter/material.dart';
import '../huong_dan/screen_todo.dart';
class ScreenTodoReminder extends StatelessWidget {
  const ScreenTodoReminder({super.key});
  @override Widget build(BuildContext context) => const ScreenTodo(enableReminder: true);
}
