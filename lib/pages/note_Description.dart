import 'package:flutter/material.dart';

class NoteDetails extends StatelessWidget {
  final note;
  NoteDetails({required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note Details"),
        backgroundColor: Colors.grey.shade200,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1,),
                boxShadow: [BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 4,
                  color: Colors.grey.shade300
                ),
                BoxShadow(
                  spreadRadius: 4,
                  blurRadius: 0,
                  color: Colors.grey.shade300
                )
                ]
              ),
            ),
          )
        ],
      ),
    )
  }
}
