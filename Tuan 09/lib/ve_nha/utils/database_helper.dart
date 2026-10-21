import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class DatabaseHelper {
 DatabaseHelper._();
 static final DatabaseHelper instance = DatabaseHelper._();
 Future<Database>? _database;
 Future<Database> get database => _database ??= _open();
 Future<Database> _open() async {
  try {
   return await openDatabase(join(await getDatabasesPath(), 'bai09_ve_nha.db'),
    version: 1,
    onCreate: (db, version) async {
     await db.execute('''CREATE TABLE expenses (
 id INTEGER PRIMARY KEY AUTOINCREMENT, content TEXT NOT NULL,
 amount INTEGER NOT NULL CHECK(amount > 0), note TEXT NOT NULL)''');
     await db.execute('''CREATE TABLE users (
 id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT NOT NULL UNIQUE,
 passwordHash TEXT NOT NULL, salt TEXT NOT NULL)''');
    },
   );
  } catch (_) { _database = null; rethrow; }
 }
}
