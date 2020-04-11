import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeIn extends StatelessWidget {
  final double delay;
  final Widget child;
  final bool leftToRight;

  FadeIn({this.delay, this.child, this.leftToRight});

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity").add(Duration(seconds: 1), Tween(begin: 0.0, end: 1.0)),
      Track("translate")
          .add(Duration(seconds: 1), Tween(begin: -250.0, end: 0.0)),
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(
            offset: leftToRight
                ? Offset(animation["translate"], 0)
                : Offset(0, -animation["translate"]),
            child: child),
      ),
    );
  }
}
