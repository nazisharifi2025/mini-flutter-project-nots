import 'package:flutter/material.dart';
import 'package:nots/db/database-helper.dart';

class createNote extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _createNoteState();
}

class _createNoteState extends State<createNote> {
  final database = DatabaseHelper();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _DescriptionController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
  }

  Future<void> submitform() async {
    if (_formKey.currentState!.validate()) {
      await database.insertNewNote(
        _titleController.text.trim(),
        _DescriptionController.text.trim(),
      );
      _titleController.clear();
      _DescriptionController.clear();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("A Note Added Successfully")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        title: Text("Add Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Card(
              elevation: 2,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _titleController,

                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade600),
                          ),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.edit_attributes_outlined),
                          labelText: "Note Title",
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return "Title is Required";
                          }
                          if (value!.length < 3) {
                            return "title must be 3 chars";
                          }
                        },
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _DescriptionController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Note description",
                        ),
                        maxLines: 7,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Description is Required";
                          }
                        },
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 12,
                          ),
                        ),
                        onPressed: submitform,
                        child: Text("Save"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
