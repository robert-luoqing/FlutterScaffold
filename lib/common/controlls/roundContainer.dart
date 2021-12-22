import 'package:flutter/material.dart';

class SPRoundContainer extends StatelessWidget {
  final Widget child;
  final Color? bkColor;
  final double? width;
  final double? height;
  final double radius;
  final Color? borderColor;
  final double? borderWidth;
  final GestureTapCallback? onTap;

  const SPRoundContainer(
      {required this.child,
      this.bkColor,
      this.width,
      this.height,
      this.radius = 15,
      this.borderColor,
      this.borderWidth,
      this.onTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
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

    if (onTap != null) {
      content = GestureDetector(
        onTap: () {
          onTap!();
        },
        child: content,
      );
    }

    if (width != null || height != null) {
      content = Center(
        child: content,
      );
    }

    return content;
  }
}
