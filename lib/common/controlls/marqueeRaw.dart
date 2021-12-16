import 'dart:async';

import '../../../common/utils/textSizeUtil.dart';
import 'package:flutter/material.dart';

typedef MarqueeRawPress = void Function(int index);

class MarqueeRaw extends StatefulWidget {
  final List<String> textList;
  final TextStyle textStyle;
  final Duration scrollDuration;
  final Duration stopDuration;
  final int maxLine;
  final double lineSpace;
  final MarqueeRawPress onPress;

  const MarqueeRaw(
      {Key? key,
      this.textList = const [],
      this.textStyle = const TextStyle(fontSize: 14, color: Colors.black),
      this.scrollDuration = const Duration(seconds: 1),
      this.stopDuration = const Duration(seconds: 3),
      this.maxLine = 1,
      required this.onPress,
      this.lineSpace = 0})
      : super(key: key);

  @override
  _MarqueeState createState() => _MarqueeState();
}

class _MarqueeState extends State<MarqueeRaw>
    with SingleTickerProviderStateMixin {
  List<String> get textList => widget.textList;
  Timer? stopTimer;
  late AnimationController animationConroller;
  late List<Widget> textWidgets = [];
  late List<double> textHeights = [];
  late List<int> showItems = [];
  double currentAnimationHeight = 0;
  double defaultHeight = 0;

  _resetDataFromWidget() {
    textWidgets = [];
    textHeights = [];
    showItems = [];
    for (var index = 0; index < this.textList.length; index++) {
      var text = this.textList[index];
      textWidgets.add(_renderText(index));
      textHeights.add(
          getTextSize(text, this.widget.textStyle, double.maxFinite).height);
    }

    for (var i = 0; i < this.widget.maxLine; i++) {
      if (this.textList.length > i) {
        this.showItems.add(i);
        // if (i == 0) {
        //   defaultHeight += textHeights[i];
        // } else {
        //   defaultHeight += textHeights[i] + this.widget.lineSpace;
        // }
      }
    }

    var textHeight = textHeights.length > 0 ? textHeights[0] : 15.0;
    this.defaultHeight = textHeight * this.widget.maxLine +
        (this.widget.maxLine - 1.0) * this.widget.lineSpace;

    if (textList.length > this.widget.maxLine) {
      if (stopTimer != null) {
        stopTimer!.cancel();
        stopTimer = null;
      }
      stopTimer =
          Timer.periodic(widget.stopDuration + widget.scrollDuration, (timer) {
        next();
      });
    } else {
      if (stopTimer != null) {
        stopTimer!.cancel();
        stopTimer = null;
      }
    }
  }

  _initAnimation() {
    animationConroller = AnimationController(vsync: this);
  }

  @override
  void didUpdateWidget(covariant MarqueeRaw oldWidget) {
    this._resetDataFromWidget();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    this._resetDataFromWidget();
    this._initAnimation();
    super.initState();
  }

  void next() async {
    setState(() {
      // 1. Add more to bottom
      currentAnimationHeight =
          textHeights[showItems[0]] + this.widget.lineSpace;
      var lastIndex = showItems[showItems.length - 1];
      if (this.textWidgets.length > (lastIndex + 1)) {
        showItems.add(lastIndex + 1);
      } else {
        showItems.add(0);
      }
    });
    await animationConroller.animateTo(1.0, duration: widget.scrollDuration);
    setState(() {
      animationConroller.value = 0.0;
      // 1. Remove first item
      showItems.removeAt(0);
    });
  }

  Widget _renderText(index) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        this.widget.onPress(index);
      },
      child: Text(
        textList[index],
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        style: this.widget.textStyle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (textList.length <= this.widget.maxLine) {
      var textChildren = textList.map((item) => _renderText(0)).toList();
      return Align(
        alignment: Alignment.centerLeft,
        child: Column(
          children: textChildren,
        ),
      );
    }

    var stackChildren = <Widget>[];

    var accumlateX = 0.0;
    for (var item in showItems) {
      stackChildren.add(
        Positioned(
            top: accumlateX,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
                animation: animationConroller,
                builder: (context, child) {
                  return Transform.translate(
                      offset: Offset(0,
                          -currentAnimationHeight * animationConroller.value),
                      child: this.textWidgets[item]);
                })),
      );

      accumlateX += textHeights[item] + this.widget.lineSpace;
    }

    return SizedBox(
        height: defaultHeight,
        child: ClipRect(
          child: Stack(
            children: stackChildren,
          ),
        ));
  }

  @override
  void dispose() {
    animationConroller.dispose();
    if (stopTimer != null) {
      stopTimer!.cancel();
    }

    super.dispose();
  }
}
