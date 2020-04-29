import 'package:flutter/material.dart';
import 'package:lco_workout/widgets/main_card.dart';

class ExerciseScreen extends StatefulWidget {
  ExerciseScreen({Key key}) : super(key: key);

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(child: Container()),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Let's get started",
                    style: Theme.of(context).primaryTextTheme.display1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: MainCard(),
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
