// ignore_for_file: depend_on_referenced_packages

import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject{
  @HiveField(0)
  String title;
  @HiveField(1)
  String body;
  @HiveField(2)
  final DateTime date;
  Note({
  required this.body,
  required this.title,
  required this.date
  });
}