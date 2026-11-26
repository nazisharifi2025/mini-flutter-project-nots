import 'package:flutter/material.dart';

class UpdateNote extends StatefulWidget {
  final note;
  UpdateNote({required this.note});
  @override
  State<StatefulWidget> createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _DescriptionController = TextEditingController();
  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.note["title"] ?? "");

    _DescriptionController = TextEditingController(
      text: widget.note["description"] ?? "",
    );
  }

  Future<void> submitform() async {
    if (_formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
