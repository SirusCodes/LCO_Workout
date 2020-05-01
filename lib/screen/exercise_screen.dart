import 'package:flutter/material.dart';
import 'package:lco_workout/animation_locator.dart';
import 'package:lco_workout/get_it/animation_getit.dart';
import 'package:lco_workout/widgets/main_card.dart';
import 'package:provider/provider.dart';

class ExerciseScreen extends StatefulWidget {
  ExerciseScreen({Key key}) : super(key: key);

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  @override
  void initState() {
    locator<AnimationGetIt>().editList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _heightFact = MediaQuery.of(context).size.height / 10;
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[Image.asset("assets/logo.png")],
                ),
              ),
              // Expanded(
              //   flex: 1,
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Text(
              //       "Let's get started",
              //       style: Theme.of(context)
              //           .primaryTextTheme
              //           .display1
              //           .copyWith(fontSize: _heightFact * .5),
              //       textAlign: TextAlign.center,
              //     ),
              //   ),
              // ),
              Expanded(
                flex: 5,
                child: MainCard(
                  heightFact: _heightFact,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer<AnimationGetIt>(
                    builder: (_, provider, __) {
                      return Text(
                        "Next: ${provider.nextExer}",
                        style: Theme.of(context)
                            .primaryTextTheme
                            .display1
                            .copyWith(fontSize: _heightFact * .5),
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
