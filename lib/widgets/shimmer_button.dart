import 'package:flutter/material.dart';
import 'package:lco_workout/animations/fade_slide.dart';
import 'package:shimmer/shimmer.dart';

import 'cneubutton.dart';

class ShimmerButton extends StatelessWidget {
  const ShimmerButton({
    Key key,
    @required this.height,
    this.padding = const EdgeInsets.all(15.0),
    this.delay = 2.5,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  final double height, delay;
  final EdgeInsets padding;
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return FadeSlide(
      delay: delay,
      leftToRight: false,
      child: Padding(
        padding: padding,
        child: CNeuButton(
          child: Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: Theme.of(context).buttonColor,
            child: Center(
              child: FittedBox(
                fit: BoxFit.fill,
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .primaryTextTheme
                      .display1
                      .copyWith(fontSize: height * .4),
                ),
              ),
            ),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
