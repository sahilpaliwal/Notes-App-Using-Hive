
// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:sahilapp/models/note.dart';
import 'package:sahilapp/pages/addnotepage.dart';
import 'package:sahilapp/pages/homepage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: FutureBuilder(
        future: Hive.openBox('notes'),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasError){
              return Scaffold(
                backgroundColor: Color.fromARGB(255, 0, 0, 0),
                body: Center(child: Text("An error occured", style: TextStyle(color: Colors.amber),)),
              );
            }
            return homepage();
          }else{
            // ignore: prefer_const_constructors
            return Scaffold(
              backgroundColor: Colors.black,
              // ignore: prefer_const_constructors
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.yellow,
                ),
              ),
            );
          }
        })
        ),
      );
  }
}

