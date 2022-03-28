import 'package:lingo_dragon/common/constant/colors.dart';
import 'package:lingo_dragon/common/widgets/animated_button.dart';
import '../../theme/text_style.dart';
import 'package:flutter/material.dart';
import 'layout/single_child_div.dart';

enum SPButtonPattern {
  primaryRoundButton,
  primaryRectButton,
  primaryOutlineButton,
  secondOutlineButton,
  animatedButton,
  googleLoginButton, // 欢迎页的谷歌登录按钮（特殊按钮）
  appleLoginButton, // 苹果登录按钮（特殊按钮）
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

  const SPButton(
      {Key? key,
      required this.pattern,
      required this.text,
      this.disabled = false,
      this.size = SPButtonSize.middle,
      this.suffix,
      this.icon,
      this.onPressed,
      this.fitContent = false})
      : super(key: key);
  @override
  _SPButtonState createState() => _SPButtonState();
}

class _SPButtonState extends State<SPButton> {
  _didPress() {
    if (widget.onPressed != null && widget.disabled == false) {
      widget.onPressed!();
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
          fontFamily: fontFamilyRegular)),
    );
    if (fitContent) {
      return UnconstrainedBox(child: SizedBox(height: height, child: button));
    } else {
      return SingleChildDiv(height: height, child: button);
    }
  }

  Widget _renderAnimatedButton({
    required bool isDisabled,
    required Color bkColor,
    required Color textColor,
    required double radius,
    required double height,
    required double textSize,
    required bool fitContent,
    double? borderWidth,
    Color? borderColor,
    Color? activeShadowColor,
  }) {
    var button = AnimatedButton(
      radius: radius,
      height: height,
      bgColor: isDisabled ? SPColors.disabledBtnColor : bkColor,
      borderWidth: borderWidth ?? 0,
      borderColor: borderColor ?? Colors.transparent,
      activeShadowColor: activeShadowColor,
      child: _renderContent(
        TextStyle(
            fontSize: textSize,
            color: isDisabled ? SPColors.disabledBtnTextColor : textColor,
            fontWeight: FontWeight.normal,
            fontFamily: fontFamilyRegular),
      ),
      onPressed: isDisabled ? () {} : _didPress,
    );

    if (fitContent) {
      return UnconstrainedBox(child: SizedBox(height: height, child: button));
    } else {
      return SingleChildDiv(height: height, child: button);
    }
  }

  @override
  Widget build(BuildContext context) {
    var textSizeMap = <SPButtonSize, double>{
      SPButtonSize.small: 13,
      SPButtonSize.middle: 15,
      SPButtonSize.large: 16,
    };
    var heightMap = <SPButtonSize, double>{
      SPButtonSize.small: 32,
      SPButtonSize.middle: 44,
      SPButtonSize.large: 50,
    };

    switch (widget.pattern) {
      case SPButtonPattern.primaryRoundButton:
        return _renderCommonButton(
            isDisabled: widget.disabled,
            bkColor: const Color(0xFF5467F0),
            disabledBkColor: const Color(0xFFE7E7E7),
            textColor: const Color(0xFFFFFFFF),
            disabledTextColor: const Color(0xFF979FA8),
            borderWidth: 0,
            borderColor: const Color(0xFF007AFF),
            disabledBorderColor: const Color(0xFFB1B1B1),
            radius: 30.0,
            height: heightMap[widget.size]!,
            textSize: textSizeMap[widget.size]!,
            fitContent: widget.fitContent);

      case SPButtonPattern.primaryRectButton:
        return _renderCommonButton(
            isDisabled: widget.disabled,
            bkColor: const Color(0xFF007AFF),
            disabledBkColor: const Color(0xFFB1B1B1),
            textColor: const Color(0xFFFFFFFF),
            disabledTextColor: const Color(0xFFFFFFFF),
            borderWidth: 0,
            borderColor: const Color(0xFF007AFF),
            disabledBorderColor: const Color(0xFFB1B1B1),
            radius: 0.0,
            height: heightMap[widget.size]!,
            textSize: textSizeMap[widget.size]!,
            fitContent: widget.fitContent);
      case SPButtonPattern.primaryOutlineButton:
        return _renderCommonButton(
            isDisabled: widget.disabled,
            bkColor: Colors.transparent,
            disabledBkColor: Colors.transparent,
            textColor: const Color(0xFF000000),
            disabledTextColor: Colors.grey,
            borderWidth: 2,
            borderColor: const Color(0xFF84D3FF),
            disabledBorderColor: const Color(0xFF84D3FF),
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
            textColor: const Color(0xFF000000),
            disabledTextColor: Colors.grey,
            borderWidth: 0,
            borderColor: const Color(0xFF000000),
            disabledBorderColor: const Color(0xFF000000),
            radius: 5.0,
            overlayColor: Colors.grey[100],
            height: heightMap[widget.size]!,
            textSize: textSizeMap[widget.size]!,
            fitContent: widget.fitContent);

      case SPButtonPattern.animatedButton:
        return _renderAnimatedButton(
            isDisabled: widget.disabled,
            bkColor: const Color(0xFF5467F0),
            textColor: const Color(0xFFFFFFFF),
            radius: 30,
            height: heightMap[widget.size]!,
            textSize: textSizeMap[widget.size]!,
            fitContent: widget.fitContent);

      case SPButtonPattern.googleLoginButton:
        return _renderAnimatedButton(
            isDisabled: widget.disabled,
            bkColor: Colors.white,
            textColor: const Color.fromRGBO(0, 0, 0, 0.54),
            radius: 30,
            height: heightMap[widget.size]!,
            textSize: textSizeMap[widget.size]!,
            fitContent: widget.fitContent,
            activeShadowColor: const Color(0xffDDDCE2),
            borderWidth: 2,
            borderColor: const Color(0xffDDDCE2));
      case SPButtonPattern.appleLoginButton:
        return _renderAnimatedButton(
            isDisabled: widget.disabled,
            bkColor: const Color(0xFF22273C),
            textColor: const Color(0xFFFFFFFF),
            radius: 30,
            height: heightMap[widget.size]!,
            textSize: textSizeMap[widget.size]!,
            fitContent: widget.fitContent);
    }
  }

  _renderContent(TextStyle style) {
    if (widget.suffix == null && widget.icon == null) {
      return Text(
        widget.text ?? "",
        style: style,
      );
    } else {
      List<Widget> children = [];
      if (widget.icon != null) {
        children.add(widget.icon!);
      }
      children.add(Text(
        widget.text ?? "",
        style: style,
      ));
      if (widget.suffix != null) {
        children.add(widget.suffix!);
      }
      return Row(
          mainAxisAlignment: MainAxisAlignment.center, children: children);
    }
  }
}
