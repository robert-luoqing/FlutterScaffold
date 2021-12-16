import 'package:flutter/material.dart';

import 'marqueeRaw.dart';

typedef SPMarqueeVerticalPress = void Function(int index);

class SPMarqueeVertical extends StatefulWidget {
  final List<String> data;
  final TextStyle textStyle;
  final SPMarqueeVerticalPress? onPress;
  final int maxLine;
  final double lineSpace;

  SPMarqueeVertical(
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
    return Container(
      child: MarqueeRaw(
        onPress: (index) {
          if (this.widget.onPress != null) {
            this.widget.onPress!(index);
          }
        },
        textList: this.widget.data,
        textStyle: widget.textStyle,
        scrollDuration: Duration(milliseconds: 300),
        stopDuration: Duration(seconds: 3),
        lineSpace: this.widget.lineSpace,
        maxLine: this.widget.maxLine,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
