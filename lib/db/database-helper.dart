// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DatabaseHelper {
//   static Database _database;

//   Future<Database> get database async {
//     if (_database != null) {
//       _database;
//     }
//     _database = await initDatabase();
//     return _database;
//   }

//   Future<Database> initDatabase() async {
//     final path = join(await getDatabasesPath(), "todo.db");
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) {
//         db.execute("CREATE TABLE todo(id int(11)primary ,task varchar(50))");
//       },
//     );
//   }

//   Future<int> insertTask() async {
//     final db = _database;
//     db.insert("todo", {"task": "washing The deshes"})
//   }
// }
