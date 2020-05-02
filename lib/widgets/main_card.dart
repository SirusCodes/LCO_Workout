import 'package:flutter/material.dart';
import 'package:lco_workout/animation_locator.dart';
import 'package:lco_workout/enum/card_status.dart';
import 'package:lco_workout/get_it/animation_getit.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'animated_timer.dart';

class MainCard extends StatefulWidget {
  const MainCard({Key key, this.heightFact}) : super(key: key);

  final double heightFact;

  @override
  _MainCardState createState() => _MainCardState();
}

class _MainCardState extends State<MainCard>
    with SingleTickerProviderStateMixin {
  Animation<double> mainCardAnimation;
  Animation<double> timerAnimation;
  Animation<double> restTextAnimation;
  Animation<double> imgAnimation;

  static Size _size;
  final animation = locator<AnimationGetIt>();

  @override
  void initState() {
    super.initState();
    animation.controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
  }

  @override
  void dispose() {
    animation.controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _size = MediaQuery.of(context).size;

    mainCardAnimation = Tween<double>(begin: 0, end: 9).animate(
        CurvedAnimation(parent: animation.controller, curve: Curves.easeInExpo))
      ..addListener(() {
        setState(() {});
      });

    timerAnimation =
        Tween<double>(begin: (_size.shortestSide / 2) - 40, end: 40).animate(
            CurvedAnimation(parent: animation.controller, curve: Curves.easeIn))
          ..addListener(() {
            setState(() {});
          });

    restTextAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: animation.controller, curve: Curves.easeIn));

    imgAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: animation.controller, curve: Curves.easeIn));
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
                animation: locator<AnimationGetIt>().controller,
                builder: (context, child) {
                  return child;
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned.fill(
                      child: NeuCard(
                        curveType: CurveType.flat,
                        bevel: mainCardAnimation.value,
                        decoration: NeumorphicDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: FadeTransition(
                        opacity: imgAnimation,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Image.asset("assets/images/${animation.imgExer}"),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Consumer<AnimationGetIt>(
                                builder: (_, provider, __) {
                                  return Text(
                                    provider.currentExer,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .display1
                                        .copyWith(
                                            fontSize: widget.heightFact * .4),
                                    textAlign: TextAlign.center,
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        if (animation.status == CardStatus.end)
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ScaleTransition(
                scale: restTextAnimation,
                child: FadeTransition(
                  opacity: restTextAnimation,
                  child: Shimmer.fromColors(
                    child: Text(
                      "Congratulations you have done it!!!",
                      style: TextStyle(
                        fontSize: _size.width / 7,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    baseColor: Theme.of(context).buttonColor,
                    highlightColor: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),
        if (animation.status != CardStatus.end)
          Align(
            alignment: Alignment.topCenter,
            child: FadeTransition(
              opacity: restTextAnimation,
              child: Shimmer.fromColors(
                child: Text(
                  animation.status == CardStatus.start
                      ? "Let's Start!!!"
                      : "Take some rest!",
                  style: TextStyle(
                    fontSize: _size.width / 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                baseColor: Theme.of(context).buttonColor,
                highlightColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
        if (animation.status != CardStatus.end)
          AnimatedBuilder(
            animation: locator<AnimationGetIt>().controller,
            builder: (context, child) {
              return child;
            },
            child: Positioned(
              top: timerAnimation.value,
              child: AnimatedTimer(size: timerAnimation.value),
            ),
          ),
      ],
    );
  }
}
