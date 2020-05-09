import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:lco_workout/animation_locator.dart';
import 'package:lco_workout/animations/fade_slide.dart';
import 'package:lco_workout/constants.dart';
import 'package:lco_workout/get_it/animation_getit.dart';
import 'package:lco_workout/get_it/drawer_getit.dart';
import 'package:lco_workout/screen/rep_count_time.dart';
import 'package:lco_workout/screen/sets_screen.dart';
import 'package:lco_workout/widgets/shimmer_button.dart';
import '../widgets/cneubutton.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> exerciseList = [];
  List<int> _time = [];

  final _animation = locator<AnimationGetIt>();
  final _drawer = locator<DrawerGetIt>();
  @override
  void initState() {
    super.initState();
    getList();
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/logo.png",
                      fit: BoxFit.cover,
                    ),
                    Spacer(),
                    FittedBox(
                      fit: BoxFit.cover,
                      child: IconButton(
                        icon: Icon(
                          Icons.dehaze,
                          color: Theme.of(context).buttonColor,
                          size: height / 2,
                        ),
                        onPressed: () {
                          _drawer.animateDrawer();
                        },
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
                        child: buildCard(context, exerciseList[0], _size),
                        leftToRight: true,
                      ),
                      FadeSlide(
                        delay: 1.7,
                        child: buildCard(context, exerciseList[1], _size),
                        leftToRight: true,
                      ),
                      FadeSlide(
                        delay: 2.0,
                        child: buildCard(context, exerciseList[2], _size),
                        leftToRight: true,
                      ),
                      FadeSlide(
                        delay: 2.3,
                        child: buildCard(context, exerciseList[3], _size),
                        leftToRight: true,
                      ),
                      FadeSlide(
                        delay: 2.6,
                        child: buildCard(context, exerciseList[4], _size),
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

  Padding buildCard(BuildContext context, String title, Size size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CNeuButton(
        color: Theme.of(context).primaryColor,
        onPressed: () {},
        child: SizedBox(
          height: size.height / 15,
          width: size.width,
          child: Center(
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
    _animation.rawList = rawList;
    _animation.exerciseList = exerciseList;
  }
}
