import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';

import 'animated_timer.dart';

class MainCard extends StatefulWidget {
  const MainCard({Key key}) : super(key: key);

  @override
  _MainCardState createState() => _MainCardState();
}

class _MainCardState extends State<MainCard>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));

    _animation = Tween<double>(begin: 9, end: 0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInExpo))
          ..addListener(() {
            setState(() {});
          });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: AnimatedTimer(),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: SizedBox(
                height: _size.shortestSide,
                width: _size.shortestSide,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return child;
                  },
                  child: NeuCard(
                    curveType: CurveType.flat,
                    bevel: _animation.value,
                    decoration: NeumorphicDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
