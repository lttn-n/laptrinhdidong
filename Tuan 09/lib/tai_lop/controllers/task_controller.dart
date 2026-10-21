import '../models/task.dart';
import '../utils/database_helper.dart';
class TaskController {
 Future<List<Task>> fetchTasks([String query = '']) async {
  final db = await DatabaseHelper.instance.database;
  final rows = await db.query('tasks',
      where: 'title LIKE ? OR description LIKE ?',
   whereArgs: ['%$query%', '%$query%'], orderBy: 'id ASC');
  return rows.map(Task.fromMap).toList();
 }
 Future<void> insertTask(Task task) async {
  final db = await DatabaseHelper.instance.database;
  await db.insert('tasks', task.toMap());
 }
 Future<void> updateTask(Task task) async {
  final db = await DatabaseHelper.instance.database;
  await db.update('tasks', task.toMap(), where: 'id = ?',
      whereArgs: [task.id]);
 }
 Future<void> deleteTask(int id) async {
  final db = await DatabaseHelper.instance.database;
  await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
 }
}
