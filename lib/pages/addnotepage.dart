// ignore_for_file: prefer_const_constructors, camel_case_types
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sahilapp/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahilapp/models/note.dart';

class add_note extends StatelessWidget {
  add_note({Key? key}) : super(key: key);

  final _formkey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  void _sumbit(BuildContext context) {
    if (_formkey.currentState != null && _formkey.currentState!.validate()) {
      final notes = Hive.box('notes');
      final note = Note(
          body: _bodyController.text.trim(),
          title: _titleController.text.trim(),
          date: DateTime.now());
      notes.add(note);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 30),
              height: 80,
              color: Color.fromARGB(255, 0, 0, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // ignore: prefer_const_constructors
                  IconButton(
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    icon: Icon(Icons.arrow_back),
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () => _sumbit(context),
                    icon: Icon(
                      Icons.check,
                    ),
                    color: Colors.amber,
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              color: Color.fromARGB(255, 0, 0, 0),
              child: Center(
                child: TextFormField(
                  controller: _titleController,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      hintText: "TITLE",
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey)),
                  validator: (value) => value != null && value.trim().length > 0
                      ? null
                      : "field cannot be empty",
                ),
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.all(20),
              // ignore: sort_child_properties_last
              child: TextFormField(
                controller: _bodyController,
                maxLines: 20,
                minLines: 1,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "start typing ",
                    isCollapsed: false),
                validator: (value) => value != null && value.trim().length > 0
                    ? null
                    : "field cannot be empty",
              ),
              color: Color.fromARGB(255, 0, 0, 0),
            ))
          ],
        ),
      ),
    );
  }
}
