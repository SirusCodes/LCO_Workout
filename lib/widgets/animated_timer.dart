import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lco_workout/animation_locator.dart';
import 'package:lco_workout/animations/fade_drop.dart';
import 'package:lco_workout/enum/card_status.dart';
import 'package:lco_workout/get_it/animation_getit.dart';

class AnimatedTimer extends StatefulWidget {
  AnimatedTimer({Key key, this.size = 35}) : super(key: key);
  final double size;
  @override
  _AnimatedTimerState createState() => _AnimatedTimerState();
}

class _AnimatedTimerState extends State<AnimatedTimer>
    with TickerProviderStateMixin {
  final _animation = locator<AnimationGetIt>();
  Timer _timer;

  AnimationController _unitController, _tenController, _hundredController;

  @override
  void initState() {
    super.initState();
    _unitController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _tenController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _hundredController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _unitController.forward();
    _tenController.forward();
    _hundredController.forward();
    _startTimer();
  }

  @override
  void dispose() {
    _unitController.dispose();
    _tenController.dispose();
    _hundredController.dispose();
    _timer.cancel();
    _animation.getPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context)
        .primaryTextTheme
        .display1
        .copyWith(fontSize: widget.size);

    if (_animation.hundred == 0 && _animation.ten == 0 && _animation.unit <= 5)
      theme = theme.copyWith(color: Color(0xFFff6961));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FadeDrop(
          controller: _hundredController,
          child: Text(
            _animation.hundred.toString(),
            style: theme,
          ),
        ),
        FadeDrop(
          controller: _tenController,
          child: Text(
            _animation.ten.toString(),
            style: theme,
          ),
        ),
        FadeDrop(
          controller: _unitController,
          child: Text(
            _animation.unit.toString(),
            style: theme,
          ),
        ),
        AnimatedOpacity(
          duration: Duration(milliseconds: 500),
          opacity: 1.0,
          child: Text(
            "s",
            style: theme,
          ),
        ),
      ],
    );
  }

  void _startTimer() {
    _animation.seperateTime();
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (Timer timer) {
      if (_animation.getState != CardStatus.paused) {
        if (_animation.hundred == 0 &&
            _animation.ten == 0 &&
            _animation.unit == 0) {
          _animation.nextTime();
        }
        setState(() {
          if (_animation.unit < 1) {
            _animation.unit = 9;
            _unitController.reset();
            _unitController.forward();
            if (_animation.ten < 1) {
              _animation.ten = 9;
              _animation.hundred--;
              _hundredController.reset();
              _tenController.reset();
              _hundredController.forward();
              _tenController.forward();
            } else {
              _animation.ten--;
              _tenController.reset();
              _tenController.forward();
            }
          } else {
            _animation.unit--;
            _unitController.reset();
            _unitController.forward();
          }
        });
      }
    });
  }
}
