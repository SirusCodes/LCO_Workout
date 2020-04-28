import 'package:flutter/material.dart';

class FadeDrop extends AnimatedWidget {
  const FadeDrop({
    Key key,
    @required AnimationController controller,
    @required Widget child,
  })  : _child = child,
        super(key: key, listenable: controller);

  static final _translationAnimation =
      Tween<Offset>(begin: Offset(0, -120.0), end: Offset(0, 0));
  static final _opacityAnimation = Tween(begin: 0.0, end: 1.0);
  final Widget _child;

  @override
  Widget build(BuildContext context) {
    final _controller = listenable;
    return Transform.translate(
      offset: _translationAnimation
          .animate(
              CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack))
          .value,
      child: FadeTransition(
        opacity: _opacityAnimation.animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeInExpo)),
        child: _child,
      ),
    );
  }
}
