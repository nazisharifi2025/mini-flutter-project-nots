import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), "todo.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE todo (id INTEGER PRIMARY KEY AUTOINCREMENT, task TEXT NOT NULL)",
        );
      },
    );
  }

  Future<int> insertTask(String task) async {
    final db = await database;
    return await db.insert("todo", {"task": task});
  }

  Future<List<Map<String, dynamic>>> getTodo() async {
    final db = await database;
    return await db.query("todo", orderBy: "id ASC");
  }

  Future<void> DeletTask(int id) async {
    final db = await database;
    await db.delete("todo", where: 'id = ?', whereArgs: [id]);
  }
}
