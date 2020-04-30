import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:neumorphic/neumorphic.dart';

class CNeuButton extends StatefulWidget {
  const CNeuButton({
    @required this.onPressed,
    this.child,
    this.padding = const EdgeInsets.all(12.0),
    this.shape = BoxShape.rectangle,
    this.color,
    Key key,
  }) : super(key: key);

  final Widget child;

  final VoidCallback onPressed;

  final EdgeInsetsGeometry padding;

  final BoxShape shape;
  final Color color;
  @override
  _CNeuButtonState createState() => _CNeuButtonState();
}

class _CNeuButtonState extends State<CNeuButton> {
  bool _isPressed = false;

  void _toggle(bool value) {
    if (_isPressed != value) {
      setState(() {
        _isPressed = value;
      });
    }
  }

  void _tapDown() => _toggle(true);

  void _tapUp() => _toggle(false);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _tapDown(),
      onTapUp: (_) => _tapUp(),
      onTapCancel: _tapUp,
      onTap: widget.onPressed,
      child: NeuCard(
        bevel: _isPressed ? 5 : 16,
        curveType: _isPressed ? CurveType.flat : CurveType.emboss,
        padding: widget.padding,
        child: widget.child,
        alignment: Alignment.center,
        decoration: NeumorphicDecoration(
          color: widget.color,
          borderRadius: widget.shape == BoxShape.circle
              ? null
              : BorderRadius.circular(16),
          shape: widget.shape,
        ),
      ),
    );
  }
}
