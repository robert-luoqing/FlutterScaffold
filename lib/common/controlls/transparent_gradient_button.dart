import 'package:flutter/material.dart';

class TransparentGradientButton extends StatelessWidget {
  final _GradientPainter _painter;
  final Widget child;
  final VoidCallback onPressed;
  final double radius;
  final double strokeWidth;
  final Gradient backgroundGradient;

  TransparentGradientButton({
    Key? key,
    required this.strokeWidth,
    required this.radius,
    required Gradient borderGradient,
    required this.child,
    required this.onPressed,
    required this.backgroundGradient,
  })  : _painter = _GradientPainter(
            strokeWidth: strokeWidth, radius: radius, gradient: borderGradient),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _painter,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onPressed,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: onPressed,
          child: Padding(
            padding: EdgeInsets.all(strokeWidth),
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(radius - strokeWidth)),
                gradient: backgroundGradient,
                // color: Colors.black
              ),
              constraints: const BoxConstraints(minWidth: 88, minHeight: 48),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  child,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GradientPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  _GradientPainter(
      {required this.strokeWidth,
      required this.radius,
      required this.gradient});

  @override
  void paint(Canvas canvas, Size size) {
    // create outer rectangle equals size
    Rect outerRect = Offset.zero & size;
    var outerRRect =
        RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    // create inner rectangle smaller by strokeWidth
    Rect innerRect = Rect.fromLTWH(strokeWidth, strokeWidth,
        size.width - strokeWidth * 2, size.height - strokeWidth * 2);
    var innerRRect = RRect.fromRectAndRadius(
        innerRect, Radius.circular(radius - strokeWidth));

    // apply gradient shader
    _paint.shader = gradient.createShader(outerRect);

    // create difference between outer and inner paths and draw it
    Path path1 = Path()..addRRect(outerRRect);
    Path path2 = Path()..addRRect(innerRRect);
    var path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}
