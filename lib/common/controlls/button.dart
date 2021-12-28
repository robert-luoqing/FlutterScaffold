import '../../../common/utils/textStyleUtil.dart';
import 'package:flutter/material.dart';

enum SPButtonPattern {
  primaryRoundButton,
  primaryRectButton,
  primaryOutlineButton,
  secondOutlineButton
}

enum SPButtonSize { small, middle, large }

class SPButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final SPButtonPattern pattern;
  final String? text;
  final Widget? suffix;
  final Widget? icon;
  final bool disabled;
  final SPButtonSize size;
  final bool fitContent;

  SPButton(
      {required this.pattern,
      required this.text,
      this.disabled = false,
      this.size = SPButtonSize.middle,
      this.suffix,
      this.icon,
      this.onPressed,
      this.fitContent = false});
  @override
  _SPButtonState createState() => _SPButtonState();
}

class _SPButtonState extends State<SPButton> {
  _didPress() {
    if (this.widget.onPressed != null && widget.disabled == false) {
      this.widget.onPressed!();
    }
  }

  Widget _renderCommonButton(
      {required bool isDisabled,
      required Color bkColor,
      required Color textColor,
      required Color disabledTextColor,
      required Color disabledBkColor,
      required Color disabledBorderColor,
      required double borderWidth,
      required Color borderColor,
      required double radius,
      required double height,
      required double textSize,
      required bool fitContent,
      Color? overlayColor}) {
    var button = ElevatedButton(
      style: ButtonStyle(
        overlayColor: overlayColor == null
            ? null
            : MaterialStateProperty.all(overlayColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
                side: BorderSide(
                    width: borderWidth,
                    color: isDisabled ? disabledBorderColor : borderColor))),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        backgroundColor:
            MaterialStateProperty.all(isDisabled ? disabledBkColor : bkColor),
      ),
      onPressed: isDisabled ? null : _didPress,
      child: _renderContent(TextStyle(
          fontSize: textSize,
          color: isDisabled ? disabledTextColor : textColor,
          fontWeight: FontWeight.normal,
          fontFamily: FontFamily_Regular)),
    );
    if (fitContent) {
      return Center(child: SizedBox(height: height, child: button));
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [SizedBox(height: height, child: button)],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var textSizeMap = <SPButtonSize, double>{
      SPButtonSize.small: 13,
      SPButtonSize.middle: 15,
      SPButtonSize.large: 17,
    };
    var heightMap = <SPButtonSize, double>{
      SPButtonSize.small: 32,
      SPButtonSize.middle: 44,
      SPButtonSize.large: 60,
    };

    switch (this.widget.pattern) {
      case SPButtonPattern.primaryRoundButton:
        return _renderCommonButton(
            isDisabled: widget.disabled,
            bkColor: Color(0xFF007AFF),
            disabledBkColor: Color(0xFFB1B1B1),
            textColor: Color(0xFFFFFFFF),
            disabledTextColor: Color(0xFFFFFFFF),
            borderWidth: 0,
            borderColor: Color(0xFF007AFF),
            disabledBorderColor: Color(0xFFB1B1B1),
            radius: 5.0,
            height: heightMap[widget.size]!,
            textSize: textSizeMap[widget.size]!,
            fitContent: widget.fitContent);

      case SPButtonPattern.primaryRectButton:
        return _renderCommonButton(
            isDisabled: widget.disabled,
            bkColor: Color(0xFF007AFF),
            disabledBkColor: Color(0xFFB1B1B1),
            textColor: Color(0xFFFFFFFF),
            disabledTextColor: Color(0xFFFFFFFF),
            borderWidth: 0,
            borderColor: Color(0xFF007AFF),
            disabledBorderColor: Color(0xFFB1B1B1),
            radius: 0.0,
            height: heightMap[widget.size]!,
            textSize: textSizeMap[widget.size]!,
            fitContent: widget.fitContent);
      case SPButtonPattern.primaryOutlineButton:
        return _renderCommonButton(
            isDisabled: widget.disabled,
            bkColor: Colors.transparent,
            disabledBkColor: Colors.transparent,
            textColor: Color(0xFF000000),
            disabledTextColor: Colors.grey,
            borderWidth: 2,
            borderColor: Color(0xFF84D3FF),
            disabledBorderColor: Color(0xFF84D3FF),
            radius: 5.0,
            overlayColor: Colors.grey[100],
            height: heightMap[widget.size]!,
            textSize: textSizeMap[widget.size]!,
            fitContent: widget.fitContent);

      case SPButtonPattern.secondOutlineButton:
        return _renderCommonButton(
            isDisabled: widget.disabled,
            bkColor: Colors.transparent,
            disabledBkColor: Colors.transparent,
            textColor: Color(0xFF000000),
            disabledTextColor: Colors.grey,
            borderWidth: 0,
            borderColor: Color(0xFF000000),
            disabledBorderColor: Color(0xFF000000),
            radius: 5.0,
            overlayColor: Colors.grey[100],
            height: heightMap[widget.size]!,
            textSize: textSizeMap[widget.size]!,
            fitContent: widget.fitContent);
    }
  }

  _renderContent(TextStyle style) {
    if (this.widget.suffix == null && this.widget.icon == null) {
      return Text(
        this.widget.text ?? "",
        style: style,
      );
    } else {
      List<Widget> children = [];
      if (this.widget.icon != null) {
        children.add(this.widget.icon!);
      }
      children.add(Text(
        this.widget.text ?? "",
        style: style,
      ));
      if (this.widget.suffix != null) {
        children.add(this.widget.suffix!);
      }
      return Row(
          mainAxisAlignment: MainAxisAlignment.center, children: children);
    }
  }
}
