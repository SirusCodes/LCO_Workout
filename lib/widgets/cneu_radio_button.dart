import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CNeumorphicRadio<T> extends StatelessWidget {
  final Widget child;
  final T value;
  final T groupValue;
  final NeumorphicBoxShape boxShape;
  final EdgeInsets padding;
  final NeumorphicRadioStyle style;
  final NeumorphicRadioListener<T> onChanged;
  final bool isEnabled;

  final Duration duration;
  final Curve curve;

  CNeumorphicRadio({
    this.child,
    this.style = const NeumorphicRadioStyle(),
    this.value,
    this.boxShape,
    this.curve = Neumorphic.DEFAULT_CURVE,
    this.duration = Neumorphic.DEFAULT_DURATION,
    this.padding = EdgeInsets.zero,
    this.groupValue,
    this.onChanged,
    this.isEnabled = true,
  });

  bool get isSelected => this.value != null && this.value == this.groupValue;

  void _onClick() {
    if (this.onChanged != null) {
      if (this.value == this.groupValue) {
        //unselect
        this.onChanged(null);
      } else {
        this.onChanged(this.value);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);

    final double selectedDepth =
        -1 * (this.style.selectedDepth ?? theme.depth).abs();
    final double unselectedDepth =
        (this.style.unselectedDepth ?? theme.depth).abs();

    double depth = isSelected ? selectedDepth : unselectedDepth;
    if (!this.isEnabled) {
      depth = 0;
    }

    return NeumorphicButton(
      onClick: () {
        _onClick();
      },
      duration: this.duration,
      curve: this.curve,
      padding: this.padding,
      pressed: isSelected,
      minDistance: selectedDepth,
      boxShape: this.boxShape ??
          NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(5)),
      child: this.child,
      style: NeumorphicStyle(
        disableDepth: this.style.disableDepth,
        intensity: this.style.intensity,
        depth: depth,
        color: Theme.of(context).primaryColor,
        shape: this.style.shape ?? NeumorphicShape.flat,
      ),
    );
  }
}
