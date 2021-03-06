import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:lco_workout/animation_locator.dart';
import 'package:lco_workout/animations/fade_slide.dart';
import 'package:lco_workout/constants.dart';
import 'package:lco_workout/get_it/animation_getit.dart';
import 'package:lco_workout/screen/exercise_detail.dart';
import 'package:lco_workout/screen/rep_count_time.dart';
import 'package:lco_workout/screen/sets_screen.dart';
import 'package:lco_workout/widgets/shimmer_button.dart';
import '../widgets/cneubutton.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.list}) : super(key: key);
  final List<String> list;
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> exerciseList = [];
  List<int> _time = [];
  List<String> _rawList = [];

  final _animation = locator<AnimationGetIt>();
  @override
  void initState() {
    super.initState();
    if (widget.list == null)
      getList();
    else
      _formatExercise(widget.list);
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    final height = _size.height / 10;

    return Material(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Row(
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
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox.expand(
                    child: FittedBox(
                      child: Text(
                        "Today's exercise includes",
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline1
                            .copyWith(fontSize: height * .5),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Column(
                    children: <Widget>[
                      FadeSlide(
                        delay: 1.5,
                        child: buildCard(
                            context, exerciseList[0], _rawList[0], _size),
                        leftToRight: true,
                      ),
                      FadeSlide(
                        delay: 1.7,
                        child: buildCard(
                            context, exerciseList[1], _rawList[1], _size),
                        leftToRight: true,
                      ),
                      FadeSlide(
                        delay: 2.0,
                        child: buildCard(
                            context, exerciseList[2], _rawList[2], _size),
                        leftToRight: true,
                      ),
                      FadeSlide(
                        delay: 2.3,
                        child: buildCard(
                            context, exerciseList[3], _rawList[3], _size),
                        leftToRight: true,
                      ),
                      FadeSlide(
                        delay: 2.6,
                        child: buildCard(
                            context, exerciseList[4], _rawList[4], _size),
                        leftToRight: true,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    // Custom rep count
                    Expanded(
                      child: ShimmerButton(
                        delay: 2.3,
                        height: height,
                        text: "Set custom rep count >",
                        padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 0),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RepCountScreen(timeList: _time),
                          ),
                        ),
                      ),
                    ),
                    // default rep count
                    Expanded(
                      child: ShimmerButton(
                        height: height,
                        text: "Set automatic reps count >",
                        onPressed: () {
                          List<int> _timeList = List<int>();
                          for (var i = 0; i < 5; i++) {
                            _timeList.add(_time[i] != 0 ? 15 * _time[i] : 60);
                          }
                          _animation.setTime = _timeList;

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => SetsScreen()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding buildCard(BuildContext context, String title, String raw, Size size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CNeuButton(
        color: Theme.of(context).primaryColor,
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ExerciseDetail(
                      exercise: title,
                      raw: raw,
                    ))),
        child: SizedBox(
          height: size.height / 15,
          width: size.width,
          child: Center(
            child: Hero(
              tag: raw,
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .primaryTextTheme
                    .headline1
                    .copyWith(fontSize: size.height / 30),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getList() {
    List<String> rawList = [];

    Random random = Random();
    int count = 5, i;
    while (count > 0) {
      i = random.nextInt(5 + count);
      var item = images[i];
      if (!rawList.contains(item)) {
        rawList.add(item);
        _time.add(DEFAULT_TIME[item]);
        item = item.replaceAll("_", " ").replaceFirst(".png", "").toUpperCase();
        exerciseList.add(item);
        count--;
      }
    }
    _rawList = rawList;
    _animation.rawList = rawList;
    _animation.exerciseList = exerciseList;
  }

  _formatExercise(List<String> list) {
    _animation.rawList = list;
    _rawList = list;
    for (var item in list) {
      _time.add(DEFAULT_TIME.containsKey(item) ? DEFAULT_TIME[item] : 5);
      item = item.replaceAll("_", " ").replaceFirst(".png", "").toUpperCase();
      exerciseList.add(item);
    }

    _animation.exerciseList = exerciseList;
  }
}
