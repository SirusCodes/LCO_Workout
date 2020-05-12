import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lco_workout/model/exercise_model.dart';

class ExerciseDetail extends StatefulWidget {
  const ExerciseDetail({Key key, this.exercise, this.raw}) : super(key: key);
  final String exercise, raw;

  @override
  _ExerciseDetailState createState() => _ExerciseDetailState();
}

class _ExerciseDetailState extends State<ExerciseDetail> {
  // ExerciseName _exercise = ExerciseName();

  Future<String> _loadExerciseAsset() async {
    return await rootBundle.loadString("assets/data/data.json");
  }

  Future loadExercise(String exercise) async {
    String jsonString = await _loadExerciseAsset();
    final jsonResponse = json.decode(jsonString);
    return ExerciseName.fromJson(jsonResponse, exercise);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 10;

    return Material(
      color: Theme.of(context).primaryColor,
      child: FutureBuilder(
        future: loadExercise(widget.raw),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return Column(
              children: <Widget>[
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    FittedBox(
                      child: IconButton(
                        splashColor: Theme.of(context).buttonColor,
                        icon: Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).buttonColor,
                          size: height * .6,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    )
                  ],
                ),
                Flexible(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Image.asset(
                              "assets/images/${widget.raw}",
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset("assets/logo.png"),
                            ),
                          ),
                          Text(
                            widget.exercise,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .headline1
                                .copyWith(fontSize: height * .5),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10),
                                Text(
                                  "Target muscles:",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline1
                                      .copyWith(fontSize: height / 3),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  snapshot.data.getExercise.getTarget,
                                  style: TextStyle(
                                    fontSize: height / 4,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "How to do:",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline1
                                      .copyWith(fontSize: height / 3),
                                ),
                                SizedBox(height: 10),
                                _text(height, snapshot),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Text _text(double height, AsyncSnapshot snapshot) {
    String _data = snapshot.data.getExercise.getHow.replaceAll(". ", ".\n\n");
    return Text(
      _data,
      style: TextStyle(
        fontSize: height / 4,
      ),
    );
  }
}
