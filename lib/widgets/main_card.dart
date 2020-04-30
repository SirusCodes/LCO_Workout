import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:shimmer/shimmer.dart';

import 'animated_timer.dart';

class MainCard extends StatefulWidget {
  const MainCard({Key key}) : super(key: key);

  @override
  _MainCardState createState() => _MainCardState();
}

class _MainCardState extends State<MainCard>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _mainCardAnimation;
  Animation<double> _timerAnimation;
  Animation<double> _restTextAnimation;

  static Size _size;
  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _controller.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _size = MediaQuery.of(context).size;

    _mainCardAnimation = Tween<double>(begin: 9, end: 0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInExpo))
          ..addListener(() {
            setState(() {});
          });

    _timerAnimation =
        Tween<double>(begin: 40, end: (_size.shortestSide / 2) - 40)
            .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn))
              ..addListener(() {
                setState(() {});
              });

    _restTextAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SizedBox(
              height: _size.shortestSide,
              width: _size.shortestSide,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return child;
                },
                child: NeuCard(
                  curveType: CurveType.flat,
                  bevel: _mainCardAnimation.value,
                  decoration: NeumorphicDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: FadeTransition(
              opacity: _restTextAnimation,
              child: Shimmer.fromColors(
                child: Text(
                  "Take some rest!",
                  style: TextStyle(
                    fontSize: _size.width / 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                baseColor: Theme.of(context).buttonColor,
                highlightColor: Theme.of(context).primaryColor,
              )),
        ),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return child;
          },
          child: Positioned(
            top: _timerAnimation.value,
            child: AnimatedTimer(size: _timerAnimation.value),
          ),
        ),
      ],
    );
  }
}
