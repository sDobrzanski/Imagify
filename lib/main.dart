import 'package:flutter/material.dart';
import 'package:imagify/screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(accentColor: Color(0xFF7C4DFF)),
      home: HomePage(),
    );
  }
}
