import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';

class ExerciseScreen extends StatefulWidget {
  ExerciseScreen({Key key}) : super(key: key);

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
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
              Expanded(child: Container()),
              Expanded(
                flex: 4,
                child: buildCard(context),
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildCard(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: SizedBox(
        height: _size.shortestSide,
        width: _size.shortestSide,
        child: NeuCard(
          curveType: CurveType.flat,
          bevel: 8,
          decoration: NeumorphicDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
