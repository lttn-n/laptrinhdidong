import '../models/expense.dart';
import '../utils/database_helper.dart';
class ExpenseController {
 Future<List<Expense>> fetchAll([String query = '']) async {
  final db = await DatabaseHelper.instance.database;
  final rows = await db.query('expenses', where: 'content LIKE ?',
      whereArgs: ['%$query%'], orderBy: 'id DESC');
  return rows.map(Expense.fromMap).toList();
 }
 Future<void> save(Expense item) async {
  final db = await DatabaseHelper.instance.database;
  if (item.id == null) { await db.insert('expenses', item.toMap()); }
  else { await db.update('expenses', item.toMap(), where: 'id = ?', whereArgs: [item.id]); }
 }
 Future<void> delete(int id) async {
  final db = await DatabaseHelper.instance.database;
  await db.delete('expenses', where: 'id = ?', whereArgs: [id]);
 }
}
