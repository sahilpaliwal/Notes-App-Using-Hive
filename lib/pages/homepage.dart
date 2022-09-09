// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sahilapp/models/note.dart';
import 'package:sahilapp/pages/addnotepage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sahilapp/pages/notedetailpage.dart';

class homepage extends StatelessWidget {
  const homepage({Key? key}) : super(key: key);

  Widget _listtile({
    required BuildContext context,
    required Note note,
    required int index,
  }) {
    return InkWell(
      onTap: () => Navigator.push(context ,MaterialPageRoute(builder: (context) => NoteDetailScreen(index: index)),),
      child: Card(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        color: Color.fromARGB(255, 39, 39, 39),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView (
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18.0),
                  ),
                const SizedBox(height: 4.0,),
                Text(
                  DateFormat.MMMMEEEEd().format(note.date),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.caption,
                  ),
                const SizedBox(height: 8.0,),
                Text(
                  note.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          centerTitle: true,
          title: Text(
            "N O T E S",
            style: TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
                fontSize: 30),
          ),
        ),
        body: ValueListenableBuilder(
            valueListenable: Hive.box('notes').listenable(),
            builder: (context, Box<dynamic> notes, _) {
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  Note note = notes.getAt(index);
                  return _listtile(context: context, note: note, index: index);
                },
                itemCount: notes.length,
              );
            }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amberAccent,
          child: Icon(Icons.add,size: 35,),
          onPressed: (() {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => add_note()));
          }),
        ));
  }
}
