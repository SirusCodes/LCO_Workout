import 'package:flutter/animation.dart';
import 'package:lco_workout/enum/drawer_state.dart';

class DrawerGetIt {
  AnimationController controller;

  DrawerState state = DrawerState.closed;

  _showDrawer() {
    state = DrawerState.open;
    controller.forward();
  }

  _hideDrawer() {
    state = DrawerState.closed;
    controller.reverse();
  }

  animateDrawer() {
    state == DrawerState.closed ? _showDrawer() : _hideDrawer();
  }
}
