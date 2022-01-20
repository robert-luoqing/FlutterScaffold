import '../../theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum SPIconWithTextButtonPattern {
  normal,
  // ignore: constant_identifier_names
  B12_EC6B1B_Style,
  // ignore: constant_identifier_names
  B12_D9D8D7_Style,
  // ignore: constant_identifier_names
  B10_727071_Style,
  // ignore: constant_identifier_names
  B10_000403_Style,
  // ignore: constant_identifier_names
  B12_000403_Style,
  // ignore: constant_identifier_names
  B10_96989E_Style,
}

class SPIconWithTextButton extends StatelessWidget {
  final Widget image;
  final SPIconWithTextButtonPattern pattern;
  final String text;
  final VoidCallback onPress;
  final double? verticleSpace;

  const SPIconWithTextButton(
      {required this.image,
      required this.pattern,
      required this.text,
      required this.onPress,
      this.verticleSpace,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (pattern) {
      case SPIconWithTextButtonPattern.B12_EC6B1B_Style:
        return GestureDetector(
            onTap: onPress,
            behavior: HitTestBehavior.opaque,
            child: Column(
              children: [
                Flexible(
                  child: image,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Center(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: SPTextStyle.text12cEC6B1BStyle,
                    ),
                  ),
                )
              ],
            ));
      case SPIconWithTextButtonPattern.B12_D9D8D7_Style:
        return GestureDetector(
            onTap: onPress,
            behavior: HitTestBehavior.opaque,
            child: Column(
              children: [
                Flexible(
                  child: image,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Center(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: SPTextStyle.text12cD9D8D7Style,
                    ),
                  ),
                )
              ],
            ));
      case SPIconWithTextButtonPattern.B10_727071_Style:
        return GestureDetector(
            onTap: onPress,
            behavior: HitTestBehavior.opaque,
            child: Column(
              children: [
                Flexible(
                  child: image,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: verticleSpace == null ? 4.0 : verticleSpace!),
                  child: Center(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: SPTextStyle.text10c727071Style,
                    ),
                  ),
                )
              ],
            ));
      case SPIconWithTextButtonPattern.B10_000403_Style:
        return GestureDetector(
            onTap: onPress,
            behavior: HitTestBehavior.opaque,
            child: Column(
              children: [
                Flexible(
                  child: image,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: verticleSpace == null ? 4.0 : verticleSpace!),
                  child: Center(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: SPTextStyle.text10c000403Style,
                    ),
                  ),
                )
              ],
            ));
      case SPIconWithTextButtonPattern.B12_000403_Style:
        return GestureDetector(
            onTap: onPress,
            behavior: HitTestBehavior.opaque,
            child: Column(
              children: [
                Flexible(
                  child: image,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: verticleSpace == null ? 4.0 : verticleSpace!),
                  child: Center(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: SPTextStyle.text12c000403Style,
                    ),
                  ),
                )
              ],
            ));
      case SPIconWithTextButtonPattern.B10_96989E_Style:
        return GestureDetector(
            onTap: onPress,
            behavior: HitTestBehavior.opaque,
            child: Column(
              children: [
                Flexible(
                  child: image,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: verticleSpace == null ? 4.0 : verticleSpace!),
                  child: Center(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: SPTextStyle.text10c96989EStyle,
                    ),
                  ),
                )
              ],
            ));
      default:
        return GestureDetector(
            onTap: onPress,
            behavior: HitTestBehavior.opaque,
            child: Column(
              children: [image, Center(child: Text(text))],
            ));
    }
  }
}
