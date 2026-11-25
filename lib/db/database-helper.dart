//

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
    final path = join(await getDatabasesPath(), "note.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL,description TEXT NOT NULL ,created_at DATETIME DEFAULT CURRENT_TIMESTAMP)",
        );
      },
    );
  }

  Future<int> insertNewNote(String title, String description) async {
    final db = await database;
    return await db.insert("notes", {
      "title": title,
      "description": description,
    });
  }

  Future<List<Map<String, dynamic>>> getNote() async {
    final db = await database;
    return await db.query("notes", orderBy: "id ASC");
  }

  Future<void> DeleteNote(int id) async {
    final db = await database;
    await db.delete("notes", where: 'id = $id');
  }

  Future<List<Map<String, dynamic>>> SearchNote(String searchText) async {
    final db = await database;
    return await db.query(
      "notes",
      where: "LOWER(title) LIKE LOWER(?)",
      whereArgs: ["%$searchText%"],
    );
  }
}
