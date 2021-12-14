import 'package:flutter/material.dart';

class SPRoundContainer2 extends StatelessWidget {
  final Widget child;
  final Color? bkColor;
  final double? width;
  final double height;
  final double radius;
  final Color? borderColor;
  final double? borderWidth;

  const SPRoundContainer2(
      {required this.child,
      this.bkColor,
      this.width,
      this.height = 30,
      this.radius = 15,
      this.borderColor,
      this.borderWidth,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: child,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: this.bkColor,
        border: this.borderColor == null
            ? null
            : Border.all(
                color: this.borderColor!, width: this.borderWidth ?? 0),
      ),
    );
  }
}
