import 'package:flutter/material.dart';
import './app_screens/firstscreen.dart';

void main() {
  runApp(MyFlutterApp());
}

class MyFlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Practice app',
      home: Scaffold(
          appBar: AppBar(
            title: Text("Screen"),
            backgroundColor: Colors.red,
	    elevation:6.0,
          ),
          body: FirstScreen()),
    );
  }
}
