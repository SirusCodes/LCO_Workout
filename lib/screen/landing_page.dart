import 'package:flutter/material.dart';
import 'package:lco_workout/animation_locator.dart';
import 'package:lco_workout/get_it/drawer_getit.dart';
import 'package:lco_workout/screen/cdrawer.dart';
import 'package:lco_workout/screen/main_screen.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  bool _canBeDragged = false;
  final double maxSlide = 250.0;

  Animation<double> _animation;
  final _drawer = locator<DrawerGetIt>();

  @override
  void initState() {
    super.initState();
    _drawer.controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
  }

  @override
  void didChangeDependencies() {
    final _size = MediaQuery.of(context).size;

    super.didChangeDependencies();
    _animation = Tween<double>(begin: 0, end: _size.height / 3).animate(
        CurvedAnimation(parent: _drawer.controller, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return GestureDetector(
      onVerticalDragStart: _onDragStart,
      onVerticalDragUpdate: _onDragUpdate,
      onVerticalDragEnd: _onDragEnd,
      child: AnimatedBuilder(
        animation: _drawer.controller,
        builder: (context, child) {
          return child;
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned.fill(
              top: _animation.value - 10,
              bottom: -(_animation.value - 10),
              child: MainPage(),
            ),
            Positioned(
              top: -(_size.height / 3) + _animation.value - 10,
              bottom: _size.height - (_animation.value),
              left: 0,
              right: 0,
              child: CDrawer(),
            ),
          ],
        ),
      ),
    );
  }

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromTop = _drawer.controller.isDismissed;
    bool isDragCloseFromBottom = _drawer.controller.isCompleted;
    _canBeDragged = isDragOpenFromTop || isDragCloseFromBottom;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta / maxSlide;
      _drawer.controller.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    double _kMinFlingVelocity = 370.0;

    if (_drawer.controller.isDismissed || _drawer.controller.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dy.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dy /
          MediaQuery.of(context).size.height;

      _drawer.controller.fling(velocity: visualVelocity);
    } else if (_drawer.controller.value < 0.5) {
      _drawer.controller.reverse();
    } else {
      _drawer.controller.forward();
    }
  }
}
