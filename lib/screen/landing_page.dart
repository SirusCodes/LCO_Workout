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

    return AnimatedBuilder(
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
            top: -(_size.height / 3) + _animation.value,
            bottom: _size.height - (_animation.value),
            left: 0,
            right: 0,
            child: CDrawer(),
          ),
        ],
      ),
    );
  }
}
