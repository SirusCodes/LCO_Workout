import 'package:flutter/material.dart';
import 'package:lco_workout/animations/fade_slide.dart';
import 'package:lco_workout/screen/sets_screen.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_animations/simple_animations.dart';
import '../widgets/cneubutton.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final tween = MultiTrackTween([
    Track("fade").add(Duration(seconds: 1), Tween(begin: 0.0, end: 1.0)),
    Track("translate").add(Duration(seconds: 1), Tween(begin: 130.0, end: 0.0))
  ]);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(child: Container()),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Let's see what we have for today",
                    style: Theme.of(context).primaryTextTheme.display1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  children: <Widget>[
                    FadeSlide(
                      delay: 1.5,
                      child: buildCard(context, "1"),
                      leftToRight: true,
                    ),
                    FadeSlide(
                      delay: 1.7,
                      child: buildCard(context, "2"),
                      leftToRight: true,
                    ),
                    FadeSlide(
                      delay: 2.0,
                      child: buildCard(context, "3"),
                      leftToRight: true,
                    ),
                    FadeSlide(
                      delay: 2.3,
                      child: buildCard(context, "4"),
                      leftToRight: true,
                    ),
                    FadeSlide(
                      delay: 2.6,
                      child: buildCard(context, "5"),
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
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: SizedBox(
                      width: _size.size.width / 2 + 10,
                      child: CNeuButton(
                        color: Theme.of(context).buttonColor,
                        child: Shimmer.fromColors(
                          baseColor: Colors.white,
                          highlightColor: Theme.of(context).buttonColor,
                          child: Text(
                            "Let's count sets >",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .display1
                                .copyWith(fontSize: 23.0),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildCard(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: NeuCard(
        curveType: CurveType.flat,
        bevel: 8,
        decoration: NeumorphicDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          title: Text(
            title,
            style: Theme.of(context).primaryTextTheme.display1,
          ),
        ),
      ),
    );
  }
}
