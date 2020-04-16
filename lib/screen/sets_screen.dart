import 'package:flutter/material.dart';
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
  Animation _opacityAnimation, _translationAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInExpo),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.stop();
        }
      });
    _controller.forward();

    _translationAnimation = Tween(begin: -250.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.stop();
        }
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: <Widget>[
            Expanded(child: Container()),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "How many sets would you like to do?",
                  style: Theme.of(context).primaryTextTheme.display1,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Transform.translate(
                offset: Offset(0, _translationAnimation.value),
                child: Opacity(
                  opacity: _opacityAnimation.value,
                  child: Center(
                    child: Text(
                      _count.toString(),
                      style: Theme.of(context)
                          .primaryTextTheme
                          .display1
                          .copyWith(fontSize: 150),
                    ),
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
                        size: 60,
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
                        size: 40,
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
                    width: _size.size.width / 2 + 10,
                    child: CNeuButton(
                      color: Theme.of(context).buttonColor,
                      child: Shimmer.fromColors(
                        baseColor: Colors.white,
                        highlightColor: Theme.of(context).primaryColor,
                        child: Text(
                          "Let's do it >",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .display1
                              .copyWith(fontSize: 23.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ExerciseScreen(),
                          ),
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
            .copyWith(fontSize: size),
      ),
      shape: BoxShape.circle,
      color: Theme.of(context).buttonColor,
      onPressed: onPressed,
    );
  }
}
