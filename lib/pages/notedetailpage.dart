// ignore_for_file: prefer_const_constructors

import 'package:intl/intl.dart';
import 'package:sahilapp/main.dart';
import 'package:sahilapp/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sahilapp/pages/addnotepage.dart';


class NoteDetailScreen extends StatelessWidget {
  final int index;
  NoteDetailScreen({Key? key, required this.index}) : super(key: key);

  final _notes = Hive.box("notes");

  @override
  Widget build(BuildContext context) {
    final note = _notes.getAt(index);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        actions: [
          IconButton(
            onPressed: () {
              try {
                _notes.deleteAt(index);
                Navigator.pop(context);
              } catch (e) {
                print(e);
              }
            },
            icon: Icon(Icons.delete,color: Colors.amber,),
          )
        ],
      ),
      body: SingleChildScrollView(
        child:
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(note.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                    ),
                    SizedBox(height: 12,),
                    Text(DateFormat.MMMMEEEEd().format(note.date),
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: Color.fromARGB(255, 97, 97, 97)
                    )),
                    SizedBox(height: 22,),
                    Text(
                      note.body,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              ),
    );
  }
}
