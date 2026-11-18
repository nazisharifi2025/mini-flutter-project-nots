// import 'package:flutter/material.dart';
// import 'package:nots/db/database-helper.dart';

// class InsertTodo extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _InsertTodoState();
// }

// class _InsertTodoState extends State<InsertTodo> {
//   TextEditingController _controller = TextEditingController();

//   final database = DatabaseHelper();
//   List<Map<String, dynamic>> todos = [];
//   Future<List<Map<String, dynamic>>> getTodos() async {
//     todos = await database.getTodo();
//     return todos;
//   }

//   @override
//   void initState() {
//     super.initState();
//     getTodos();
//   }

//   Future<void> saveTodo() async {
//     if (_controller.text.trim().isEmpty) return;
//     await database.insertTask(_controller.text.trim());
//     _controller.clear();
//     getTodos();
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text("A Tast Inserted Successfully")));
//   }

//   Future<void> deleteTask(int id) async {
//     await database.DeletTask(id);
//     getTodos();
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text("A Tast Deleted Successfully")));
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Todo App")),
//       body: Padding(
//         padding: EdgeInsetsGeometry.all(12),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Column(
//               children: [
//                 TextField(
//                   controller: _controller,
//                   decoration: InputDecoration(
//                     label: Text("Write Some Text"),
//                     // border
//                   ),
//                 ),
//                 MaterialButton(onPressed: saveTodo, child: Text("Save")),
//               ],
//             ),
//             Divider(),
//             ListView.builder(
//               itemCount: todos.length,
//               itemBuilder: ((context, index) {
//                 return ListTile(
//                   title: Text(todos[index]["task"]),
//                   leading: Icon(Icons.task_alt),
//                   trailing: MaterialButton(
//                     onPressed: () {
//                       deleteTask(todos[index]["id"]);
//                     },
//                     child: Icon(Icons.delete),
//                   ),
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
