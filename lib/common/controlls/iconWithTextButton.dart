import '../../../common/utils/textStyleUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum SPIconWithTextButtonPattern {
  normal,
  B12_EC6B1B_Style,
  B12_D9D8D7_Style,
  B10_727071_Style,
  B10_000403_Style,
  B12_000403_Style,
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
            onTap: this.onPress,
            behavior: HitTestBehavior.opaque,
            child: Container(
              child: Column(
                children: [
                  Flexible(
                    child: this.image,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Center(
                      child: Text(
                        this.text,
                        textAlign: TextAlign.center,
                        style: SPTextStyle.text12_EC6B1B_Style,
                      ),
                    ),
                  )
                ],
              ),
            ));
      case SPIconWithTextButtonPattern.B12_D9D8D7_Style:
        return GestureDetector(
            onTap: this.onPress,
            behavior: HitTestBehavior.opaque,
            child: Container(
              child: Column(
                children: [
                  Flexible(
                    child: this.image,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Center(
                      child: Text(
                        this.text,
                        textAlign: TextAlign.center,
                        style: SPTextStyle.text12_D9D8D7_Style,
                      ),
                    ),
                  )
                ],
              ),
            ));
      case SPIconWithTextButtonPattern.B10_727071_Style:
        return GestureDetector(
            onTap: this.onPress,
            behavior: HitTestBehavior.opaque,
            child: Container(
              child: Column(
                children: [
                  Flexible(
                    child: this.image,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: this.verticleSpace == null
                            ? 4.0
                            : this.verticleSpace!),
                    child: Center(
                      child: Text(
                        this.text,
                        textAlign: TextAlign.center,
                        style: SPTextStyle.text10_727071_Style,
                      ),
                    ),
                  )
                ],
              ),
            ));
      case SPIconWithTextButtonPattern.B10_000403_Style:
        return GestureDetector(
            onTap: this.onPress,
            behavior: HitTestBehavior.opaque,
            child: Container(
              child: Column(
                children: [
                  Flexible(
                    child: this.image,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: this.verticleSpace == null
                            ? 4.0
                            : this.verticleSpace!),
                    child: Center(
                      child: Text(
                        this.text,
                        textAlign: TextAlign.center,
                        style: SPTextStyle.text10_000403_Style,
                      ),
                    ),
                  )
                ],
              ),
            ));
      case SPIconWithTextButtonPattern.B12_000403_Style:
        return GestureDetector(
            onTap: this.onPress,
            behavior: HitTestBehavior.opaque,
            child: Container(
              child: Column(
                children: [
                  Flexible(
                    child: this.image,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: this.verticleSpace == null
                            ? 4.0
                            : this.verticleSpace!),
                    child: Center(
                      child: Text(
                        this.text,
                        textAlign: TextAlign.center,
                        style: SPTextStyle.text12_000403_Style,
                      ),
                    ),
                  )
                ],
              ),
            ));
      case SPIconWithTextButtonPattern.B10_96989E_Style:
        return GestureDetector(
            onTap: this.onPress,
            behavior: HitTestBehavior.opaque,
            child: Container(
              child: Column(
                children: [
                  Flexible(
                    child: this.image,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: this.verticleSpace == null
                            ? 4.0
                            : this.verticleSpace!),
                    child: Center(
                      child: Text(
                        this.text,
                        textAlign: TextAlign.center,
                        style: SPTextStyle.text10_96989E_Style,
                      ),
                    ),
                  )
                ],
              ),
            ));
      default:
        return GestureDetector(
            onTap: this.onPress,
            behavior: HitTestBehavior.opaque,
            child: Container(
              child: Column(
                children: [this.image, Center(child: Text(this.text))],
              ),
            ));
    }
  }
}
