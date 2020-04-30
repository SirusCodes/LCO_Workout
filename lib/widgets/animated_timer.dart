import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lco_workout/animations/fade_drop.dart';

class AnimatedTimer extends StatefulWidget {
  AnimatedTimer({Key key, this.size = 35}) : super(key: key);
  final double size;
  @override
  _AnimatedTimerState createState() => _AnimatedTimerState();
}

class _AnimatedTimerState extends State<AnimatedTimer>
    with TickerProviderStateMixin {
  Timer _timer;
  int _start = 10;
  int _unit = 0, _ten = 0, _hundred = 0;

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
    _seperateStart();
    _startTimer();
  }

  @override
  void dispose() {
    _unitController.dispose();
    _tenController.dispose();
    _hundredController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context)
        .primaryTextTheme
        .display1
        .copyWith(fontSize: widget.size);

    if (_hundred == 0 && _ten == 0 && _unit <= 5)
      theme = theme.copyWith(color: Color(0xFFff6961));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FadeDrop(
          controller: _hundredController,
          child: Text(
            _hundred.toString(),
            style: theme,
          ),
        ),
        FadeDrop(
          controller: _tenController,
          child: Text(
            _ten.toString(),
            style: theme,
          ),
        ),
        FadeDrop(
          controller: _unitController,
          child: Text(
            _unit.toString(),
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
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (Timer timer) {
      setState(() {
        if (_unit < 1) {
          _unit = 9;
          _unitController.reset();
          _unitController.forward();
          if (_ten < 1) {
            _ten = 9;
            _hundred--;
            _hundredController.reset();
            _tenController.reset();
            _hundredController.forward();
            _tenController.forward();
          } else {
            _ten--;
            _tenController.reset();
            _tenController.forward();
          }
        } else {
          _unit--;
          _unitController.reset();
          _unitController.forward();
        }
      });
    });
  }

  void _seperateStart() {
    _unit = _start % 10;
    _start = _start ~/ 10;
    _ten = _start % 10;
    _start = _start ~/ 10;
    _hundred = _start % 10;
  }
}
