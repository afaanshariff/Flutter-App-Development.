//import 'package:Notekeeper/screens/note_detail.dart';
import 'package:flutter/material.dart';
import 'package:Notekeeper/screens/note_list.dart';

void main() => runApp(NotekeeperApp());

class NotekeeperApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note Keeper App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: NoteList(),
    );
  }
}
