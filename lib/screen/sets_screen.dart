import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:lco_workout/animations/fade_drop.dart';
import 'package:lco_workout/animations/fade_slide.dart';
import 'package:lco_workout/animations/pop_in.dart';
import 'package:lco_workout/screen/exercise_screen.dart';
import 'package:lco_workout/widgets/cneubutton.dart';
import 'package:shimmer/shimmer.dart';

class SetsScreen extends StatefulWidget {
  SetsScreen({Key key}) : super(key: key);

  @override
  _SetsScreenState createState() => _SetsScreenState();
}

class _SetsScreenState extends State<SetsScreen>
    with SingleTickerProviderStateMixin {
  int _count = 1;

  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    final _heightFact = _size.height / 10;
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "How many sets would you like to do?",
                    style: Theme.of(context)
                        .primaryTextTheme
                        .display1
                        .copyWith(fontSize: _heightFact * .5),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: FadeDrop(
                controller: _controller,
                child: Center(
                  child: Text(
                    _count.toString(),
                    style: Theme.of(context)
                        .primaryTextTheme
                        .display1
                        .copyWith(fontSize: _heightFact * 3),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    PopIn(
                      child: buildButton(
                        context,
                        text: "-",
                        size: _heightFact,
                        onPressed: () {
                          setState(() {
                            if (_count != 1) {
                              _controller.reset();
                              _count--;
                              _controller.forward();
                            }
                          });
                        },
                      ),
                    ),
                    PopIn(
                      child: buildButton(
                        context,
                        text: "+",
                        size: _heightFact * .6,
                        onPressed: () {
                          setState(() {
                            _controller.reset();
                            _count++;
                            _controller.forward();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FadeSlide(
                delay: 0.5,
                leftToRight: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: SizedBox(
                    width: _size.width / 2 + 10,
                    child: CNeuButton(
                      child: Shimmer.fromColors(
                        baseColor: Colors.white,
                        highlightColor: Theme.of(context).buttonColor,
                        child: Center(
                          child: Text(
                            "Let's do it >",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .display1
                                .copyWith(fontSize: _heightFact * .4),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ExerciseScreen()),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  CNeuButton buildButton(BuildContext context,
      {String text, double size, Function onPressed}) {
    return CNeuButton(
      padding: const EdgeInsets.all(25.0),
      child: Text(
        text,
        style: Theme.of(context)
            .primaryTextTheme
            .display1
            .copyWith(fontSize: size, color: Colors.white),
      ),
      shape: NeumorphicBoxShape.circle(),
      onPressed: onPressed,
    );
  }
}
