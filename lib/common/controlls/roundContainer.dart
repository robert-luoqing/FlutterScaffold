import 'package:flutter/material.dart';

class SPRoundContainer extends StatelessWidget {
  final Widget child;
  final Color? bkColor;
  final double? width;
  final double height;
  final double radius;
  final GestureTapCallback? onTap;
  const SPRoundContainer(
      {required this.child,
      this.bkColor,
      this.width,
      this.height = 30,
      this.radius = 15,
      this.onTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (onTap != null) {
      return GestureDetector(
        onTap: () {
          onTap!();
        },
        behavior: HitTestBehavior.opaque,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: SizedBox(
            height: height,
            width: width,
            child: Container(
              color: bkColor,
              child: child,
            ),
          ),
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: SizedBox(
          height: height,
          width: width,
          child: Container(
            color: bkColor,
            child: child,
          ),
        ),
      );
    }
  }
}
