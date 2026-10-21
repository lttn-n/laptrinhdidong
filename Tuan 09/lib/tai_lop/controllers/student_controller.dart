import '../models/student.dart';
import '../utils/database_helper.dart';
class StudentController {
 Future<List<SinhVien>> fetchAll([String query = '']) async {
  final db = await DatabaseHelper.instance.database;
  final rows = await db.query('students', where: 'name LIKE ?',
      whereArgs: ['%$query%'], orderBy: 'id DESC');
  return rows.map(SinhVien.fromMap).toList();
 }
 Future<void> save(SinhVien item) async {
  final db = await DatabaseHelper.instance.database;
  if (item.id == null) { await db.insert('students', item.toMap()); }
  else { await db.update('students', item.toMap(), where: 'id = ?',
      whereArgs: [item.id]); }
 }
 Future<void> delete(int id) async {
  final db = await DatabaseHelper.instance.database;
  await db.delete('students', where: 'id = ?', whereArgs: [id]);
 }
}
