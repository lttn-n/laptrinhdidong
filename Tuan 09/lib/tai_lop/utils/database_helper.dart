import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class DatabaseHelper {
 DatabaseHelper._();
 static final DatabaseHelper instance = DatabaseHelper._();
 Future<Database>? _database;
 Future<Database> get database => _database ??= _open();
 Future<Database> _open() async {
  try {
   return await openDatabase(join(await getDatabasesPath(), 'bai09_tai_lop.db'),
    version: 1,
    onCreate: (db, version) async {
     await db.execute('''CREATE TABLE tasks (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 title TEXT NOT NULL, description TEXT NOT NULL,
 isCompleted INTEGER NOT NULL DEFAULT 0 CHECK(isCompleted IN (0,1)))''');
     await db.execute('''CREATE TABLE students (
 id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, email TEXT NOT NULL)''');
    },
   );
  } catch (_) { _database = null; rethrow; }
 }
}
