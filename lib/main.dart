import 'package:flutter/material.dart';
import 'screen/main_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFFf4f4f4),
        buttonColor: Color(0xFF798ba6),
        primaryTextTheme: TextTheme(
          display1: TextStyle(
            color: Color(0xFF6983aa),
            fontSize: 35,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: MainPage(),
    );
  }
}
