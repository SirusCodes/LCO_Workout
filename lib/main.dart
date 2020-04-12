import 'package:flutter/material.dart';
import 'screen/main_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xff8b9ca3),
        buttonColor: Color(0xff748287),
        primaryTextTheme: TextTheme(
          display1: TextStyle(
            color: Colors.white,
            fontSize: 35,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: MainPage(),
    );
  }
}
