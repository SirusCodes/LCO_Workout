import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:lco_workout/animations/fade_slide.dart';
import 'package:lco_workout/constants.dart';
import 'package:lco_workout/screen/sets_screen.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:shimmer/shimmer.dart';
import '../widgets/cneubutton.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> exerciseList = [], rawList = [];
  @override
  void initState() {
    super.initState();
    getList();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    final height = _size.height / 10;

    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Expanded(child: Container()),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Let's see what we have for today",
                      style: Theme.of(context)
                          .primaryTextTheme
                          .display1
                          .copyWith(fontSize: height * .5),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
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
              Expanded(
                child: FadeSlide(
                  delay: 2.5,
                  leftToRight: false,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: CNeuButton(
                      child: Shimmer.fromColors(
                        baseColor: Colors.white,
                        highlightColor: Theme.of(context).buttonColor,
                        child: Center(
                          child: Text(
                            "Let's count sets >",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .display1
                                .copyWith(fontSize: height * .4),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => SetsScreen()));
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildCard(BuildContext context, String title, Size size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: NeuCard(
        curveType: CurveType.flat,
        bevel: 8,
        decoration: NeumorphicDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: SizedBox(
          height: size.height / 13,
          width: size.width,
          child: Center(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .primaryTextTheme
                  .display1
                  .copyWith(fontSize: size.height / 30),
            ),
          ),
        ),
      ),
    );
  }

  void getList() {
    Random random = Random();
    int count = 5, i;
    while (count > 0) {
      i = random.nextInt(5 + count);
      var item = images[i];
      if (!rawList.contains(item)) {
        rawList.add(item);
        item = item.replaceAll("_", " ").replaceFirst(".png", "").toUpperCase();
        exerciseList.add(item);
        count--;
      }
    }
  }
}
