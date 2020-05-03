import 'package:flutter/animation.dart';
import 'package:lco_workout/enum/drawer_state.dart';

class DrawerGetIt {
  AnimationController controller;

  DrawerState state = DrawerState.closed;

  showDrawer() {
    state = DrawerState.open;
    controller.forward();
  }

  hideDrawer() {
    state = DrawerState.closed;
    controller.reverse();
  }
}
