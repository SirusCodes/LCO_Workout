import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CNeuButton extends StatefulWidget {
  const CNeuButton({
    @required this.onPressed,
    this.child,
    this.padding = const EdgeInsets.all(12.0),
    this.shape,
    Key key,
    this.color,
  }) : super(key: key);

  final Color color;

  final Widget child;

  final VoidCallback onPressed;

  final EdgeInsetsGeometry padding;

  final NeumorphicBoxShape shape;

  @override
  _CNeuButtonState createState() => _CNeuButtonState();
}

class _CNeuButtonState extends State<CNeuButton> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      padding: widget.padding,
      child: widget.child,
      style: NeumorphicStyle(
        color: widget.color ?? Theme.of(context).buttonColor,
        shadowLightColor: Color(0xffb1bac7),
        shadowDarkColor: Color(0xff7d828a),
      ),
      boxShape: widget.shape,
      onClick: widget.onPressed,
    );
  }
}
