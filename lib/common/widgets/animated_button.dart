import 'package:flutter/material.dart';
import 'package:lingo_dragon/common/constant/colors.dart';

enum AnimatedButtonPattern {
  bigBtn,
}
enum AnimatedButtonSize { small, middle, large }

class AnimatedButton extends StatefulWidget {
  final GestureTapCallback onPressed;
  final Widget child;
  final bool enabled;
  final Color bgColor;
  final double height;
  final ShadowDegree shadowDegree;
  final int duration;
  final BoxShape shape;
  final double radius;
  final double? width;
  final Color? activeShadowColor; // 按钮可用时的阴影颜色
  final Color? inactiveShadowColor; // 不可用时的阴影颜色
  final double? borderWidth;
  final Color? borderColor;

  const AnimatedButton(
      {Key? key,
      required this.onPressed,
      required this.child,
      this.enabled = true,
      this.bgColor = Colors.transparent,
      this.height = 64,
      this.shadowDegree = ShadowDegree.light,
      this.width,
      this.radius = 30,
      this.duration = 70,
      this.activeShadowColor,
      this.inactiveShadowColor,
      this.borderWidth,
      this.borderColor,
      this.shape = BoxShape.rectangle})
      : super(key: key);

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  static const Curve _curve = Curves.easeIn;
  static const double _shadowHeight = 4;
  double _position = 4;

  @override
  Widget build(BuildContext context) {
    final double _height = widget.height - _shadowHeight;
    final shadowColor = widget.enabled
        ? (widget.activeShadowColor ??
            darken(widget.bgColor, widget.shadowDegree))
        : SPColors.disabledBtnShadowColor;
    return GestureDetector(
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(widget.radius))),
          width: widget.width,
          height: _height + _shadowHeight,
          child: LayoutBuilder(builder: (context, constraints) {
            return Stack(children: <Widget>[
              Positioned(
                bottom: 0,
                child: Container(
                  height: _height,
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                      color: shadowColor,
                      borderRadius: widget.shape != BoxShape.circle
                          ? BorderRadius.all(
                              Radius.circular(widget.radius),
                            )
                          : null,
                      shape: widget.shape),
                ),
              ),
              AnimatedPositioned(
                curve: _curve,
                duration: Duration(milliseconds: widget.duration),
                bottom: _position,
                child: Container(
                  height: _height,
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: widget.borderWidth ?? 0,
                          color: widget.borderColor ?? Colors.transparent),
                      color: widget.enabled
                          ? widget.bgColor
                          : SPColors.disabledBtnColor,
                      borderRadius: widget.shape != BoxShape.circle
                          ? BorderRadius.all(
                              Radius.circular(widget.radius),
                            )
                          : null,
                      shape: widget.shape),
                  child: Center(
                    child: widget.child,
                  ),
                ),
              ),
            ]);
          })),
      onTapDown: widget.enabled ? _pressed : null,
      onTapUp: widget.enabled ? _unPressedOnTapUp : null,
      onTapCancel: widget.enabled ? _onTapCancel : null,
    );
  }

  void _pressed(_) {
    setState(() {
      _position = 0;
    });
  }

  void _onTapCancel() {
    setState(() {
      _position = 4;
    });
  }

  void _unPressedOnTapUp(_) => _unPressed();

  void _unPressed() {
    setState(() {
      _position = 4;
    });
    widget.onPressed();
  }
}

// Get a darker bgColor from any entered bgColor.
// Thanks to @NearHuscarl on StackOverflow
Color darken(Color bgColor, ShadowDegree degree) {
  double amount = degree == ShadowDegree.dark ? 0.3 : 0.06;
  final hsl = HSLColor.fromColor(bgColor);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

enum ShadowDegree { light, dark }
