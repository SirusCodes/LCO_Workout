import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';

class PopIn extends StatelessWidget {
  const PopIn({Key key, @required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final tween = Tween(begin: 0.0, end: 1.0);
    return ControlledAnimation(
      curve: Curves.easeInExpo,
      duration: Duration(seconds: 1),
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Transform.scale(
        scale: animation,
        child: child,
      ),
    );
  }
}
