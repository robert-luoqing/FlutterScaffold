import 'package:flutter/material.dart';

import 'marquee_raw.dart';

typedef SPMarqueeVerticalPress = void Function(int index);

class SPMarqueeVertical extends StatefulWidget {
  final List<String> data;
  final TextStyle textStyle;
  final SPMarqueeVerticalPress? onPress;
  final int maxLine;
  final double lineSpace;

  const SPMarqueeVertical(
      {required this.data,
      this.textStyle = const TextStyle(fontSize: 14, color: Colors.black),
      this.onPress,
      this.maxLine = 1,
      this.lineSpace = 0,
      Key? key})
      : super(key: key);

  @override
  State<SPMarqueeVertical> createState() => _MarqueeVerticalState();
}

class _MarqueeVerticalState extends State<SPMarqueeVertical> {
  @override
  Widget build(BuildContext context) {
    return MarqueeRaw(
      onPress: (index) {
        if (widget.onPress != null) {
          widget.onPress!(index);
        }
      },
      textList: widget.data,
      textStyle: widget.textStyle,
      scrollDuration: const Duration(milliseconds: 300),
      stopDuration: const Duration(seconds: 3),
      lineSpace: widget.lineSpace,
      maxLine: widget.maxLine,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
