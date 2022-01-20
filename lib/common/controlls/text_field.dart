/// The class will wrap text field and its styles.
/// Principle: Don't expose complicate style to invoker
/// Just make invoker simple ASAP to reduce complex in page or component
/// The style will be finished in cocrect work in project or coming from UX team
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/text_style.dart';
import 'package:flutter/material.dart';

enum SPTextFieldPattern { normal, textWithIcon, h35F9F, withoutBorder }

class SPTextField extends StatefulWidget {
  final TextEditingController? controller;
  final SPTextFieldPattern? pattern;
  final Widget? prefixIcon;
  final Widget? sufixIcon;
  final String? placeholder;
  final bool? obscureText;
  final VoidCallback? onFocus;
  final VoidCallback? onBlur;
  final int maxLines;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final bool? showClearButton;
  final TextInputType? keyboardType; // 键盘类型
  final bool? isWarnStyle; // 是否使用警告样式

  const SPTextField(
      {Key? key,
      this.pattern,
      this.prefixIcon,
      this.sufixIcon,
      this.placeholder,
      this.controller,
      this.obscureText,
      this.onFocus,
      this.onBlur,
      this.maxLines = 1,
      this.textInputAction,
      this.autofocus = false,
      this.showClearButton = false,
      this.keyboardType = TextInputType.text,
      this.isWarnStyle = false})
      : super(key: key);

  @override
  _SPTextFieldState createState() => _SPTextFieldState();
}

class _SPTextFieldState extends State<SPTextField> {
  late FocusNode focusNode;
  late TextEditingController myController;
  bool isShowClearButton = false;

  @override
  void initState() {
    super.initState();
    myController = widget.controller ?? TextEditingController();
    focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        if (widget.onFocus != null) {
          widget.onFocus!();
        }
      } else {
        if (widget.onBlur != null) {
          widget.onBlur!();
        }
      }

      if (widget.showClearButton == true) {
        var nextIsShowClearButton =
            focusNode.hasFocus && myController.text.isNotEmpty;
        if (isShowClearButton != nextIsShowClearButton) {
          setState(() {
            isShowClearButton = nextIsShowClearButton;
          });
        }
      }
    });
  }

  @override
  void didUpdateWidget(covariant SPTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    var oldController = oldWidget.controller;
    var newController = widget.controller;
    TextEditingController? nextController = myController;
    if (oldController == null && newController != null) {
      myController.dispose();
      nextController = null;
    }
    if (newController != null) {
      nextController = newController;
    }
    nextController ??= TextEditingController();
    if (nextController != myController) {
      setState(() {
        myController = nextController!;
      });
    }
  }

  void textDidChange(String text) {
    if (widget.showClearButton == true) {
      var nextIsShowClearButton = text.isNotEmpty;
      if (isShowClearButton != nextIsShowClearButton) {
        setState(() {
          isShowClearButton = nextIsShowClearButton;
        });
      }
    }
  }

  Widget _clearButton() {
    if (isShowClearButton && myController.text.isNotEmpty) {
      return SizedBox(
        width: 20,
        height: 20,
        child: GestureDetector(
          onTap: () {
            myController.clear();
            setState(() {
              isShowClearButton = false;
            });
          },
          child: Center(
            child: SvgPicture.asset(
              "assets/icons/common/clear_icon.svg",
              width: 20,
              height: 20,
            ),
          ),
        ),
      );
    } else {
      return const SizedBox(
        width: 20,
        height: 20,
      );
    }
  }

  Widget? _suffixView() {
    if (widget.showClearButton == true && widget.sufixIcon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [_clearButton(), widget.sufixIcon!],
      );
    } else if (widget.showClearButton == true && widget.sufixIcon == null) {
      return _clearButton();
    }
    return widget.sufixIcon;
  }

  Widget _buildTextInput() {
    TextStyle tStyle = SPTextStyle.text16c1A1C25Style;
    if (widget.isWarnStyle == true) {
      tStyle = SPTextStyle.text16cFB6566Style;
    }
    switch (widget.pattern) {
      case SPTextFieldPattern.textWithIcon:
        return Material(
          child: TextField(
            focusNode: focusNode,
            controller: myController,
            obscureText: widget.obscureText ?? false,
            maxLines: widget.maxLines,
            textInputAction: widget.textInputAction,
            autofocus: widget.autofocus,
            onChanged: textDidChange,
            decoration: InputDecoration(
                prefixIcon: widget.prefixIcon,
                suffixIcon: _suffixView(),
                hintText: widget.placeholder,
                hintStyle: SPTextStyle.text15ABAStyle),
            keyboardType: widget.keyboardType,
            style: tStyle,
          ),
        );
      case SPTextFieldPattern.withoutBorder:
        return Material(
          child: TextField(
            focusNode: focusNode,
            autofocus: widget.autofocus,
            controller: myController,
            obscureText: widget.obscureText ?? false,
            maxLines: widget.maxLines,
            textInputAction: widget.textInputAction,
            onChanged: textDidChange,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
              prefixIcon: widget.prefixIcon,
              suffixIcon: _suffixView(),
              hintText: widget.placeholder,
              hintStyle: SPTextStyle.text14cABAStyle,
              border: InputBorder.none,
            ),
            keyboardType: widget.keyboardType,
            style: tStyle,
          ),
        );
      case SPTextFieldPattern.h35F9F:
        return Material(
          child: TextField(
            focusNode: focusNode,
            autofocus: widget.autofocus,
            controller: myController,
            obscureText: widget.obscureText ?? false,
            maxLines: widget.maxLines,
            textInputAction: widget.textInputAction,
            onChanged: textDidChange,
            decoration: InputDecoration(
              prefixIcon: widget.prefixIcon,
              suffixIcon: _suffixView(),
              hintText: widget.placeholder,
              hintStyle: SPTextStyle.text14cABAStyle,
              filled: true,
              fillColor: const Color(0xFFF9F9F9),
              contentPadding:
                  const EdgeInsets.only(left: 8.0, bottom: 10.0, top: 10.0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide:
                      const BorderSide(color: Color(0xFFF9F9F9), width: 1)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide:
                      const BorderSide(color: Color(0xFFF9F9F9), width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide:
                      const BorderSide(color: Color(0xFFF9F9F9), width: 1)),
            ),
            keyboardType: widget.keyboardType,
            style: tStyle,
          ),
        );

      default:
        return Material(
          child: TextField(
            focusNode: focusNode,
            autofocus: widget.autofocus,
            controller: myController,
            obscureText: widget.obscureText ?? false,
            maxLines: widget.maxLines,
            textInputAction: widget.textInputAction,
            onChanged: textDidChange,
            decoration: InputDecoration(
                prefixIcon: widget.prefixIcon,
                suffixIcon: _suffixView(),
                hintText: widget.placeholder),
            keyboardType: widget.keyboardType,
            style: tStyle,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildTextInput();
  }

  @override
  void dispose() {
    focusNode.dispose();
    if (widget.controller == null) {
      myController.dispose();
    }
    super.dispose();
  }
}
