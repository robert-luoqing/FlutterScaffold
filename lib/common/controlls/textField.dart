/// The class will wrap text field and its styles.
/// Principle: Don't expose complicate style to invoker
/// Just make invoker simple ASAP to reduce complex in page or component
/// The style will be finished in cocrect work in project or coming from UX team
import '../../../common/utils/textStyleUtil.dart';
import 'package:flutter/material.dart';

enum SPTextFieldPattern { normal, textWithIcon, h35_F9F, withoutBorder }

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
  SPTextField(
      {this.pattern,
      this.prefixIcon,
      this.sufixIcon,
      this.placeholder,
      this.controller,
      this.obscureText,
      this.onFocus,
      this.onBlur,
      this.maxLines = 1,
      this.textInputAction,
      this.autofocus = false});

  @override
  _SPTextFieldState createState() => _SPTextFieldState();
}

class _SPTextFieldState extends State<SPTextField> {
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();

    focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        if (this.widget.onFocus != null) {
          this.widget.onFocus!();
        }
      } else {
        if (this.widget.onBlur != null) {
          this.widget.onBlur!();
        }
      }
    });
  }

  Widget _buildTextInput() {
    switch (this.widget.pattern) {
      case SPTextFieldPattern.textWithIcon:
        return Material(
          child: TextField(
              focusNode: focusNode,
              controller: this.widget.controller,
              obscureText: this.widget.obscureText ?? false,
              maxLines: this.widget.maxLines,
              textInputAction: this.widget.textInputAction,
              autofocus: this.widget.autofocus,
              decoration: InputDecoration(
                  prefixIcon: this.widget.prefixIcon,
                  suffixIcon: this.widget.sufixIcon,
                  hintText: this.widget.placeholder,
                  hintStyle: SPTextStyle.text15_ABA_Style)),
        );
      case SPTextFieldPattern.withoutBorder:
        return Material(
          child: TextField(
              focusNode: focusNode,
              autofocus: this.widget.autofocus,
              controller: this.widget.controller,
              obscureText: this.widget.obscureText ?? false,
              maxLines: this.widget.maxLines,
              textInputAction: this.widget.textInputAction,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
                prefixIcon: this.widget.prefixIcon,
                suffixIcon: this.widget.sufixIcon,
                hintText: this.widget.placeholder,
                hintStyle: SPTextStyle.text14_ABA_Style,
                border: InputBorder.none,
              )),
        );
      case SPTextFieldPattern.h35_F9F:
        return Material(
          child: TextField(
              focusNode: focusNode,
              autofocus: this.widget.autofocus,
              controller: this.widget.controller,
              obscureText: this.widget.obscureText ?? false,
              maxLines: this.widget.maxLines,
              textInputAction: this.widget.textInputAction,
              decoration: InputDecoration(
                prefixIcon: this.widget.prefixIcon,
                suffixIcon: this.widget.sufixIcon,
                hintText: this.widget.placeholder,
                hintStyle: SPTextStyle.text14_ABA_Style,
                filled: true,
                fillColor: Color(0xFFF9F9F9),
                contentPadding:
                    const EdgeInsets.only(left: 8.0, bottom: 10.0, top: 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide(color: Color(0xFFF9F9F9), width: 1)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide(color: Color(0xFFF9F9F9), width: 1)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide(color: Color(0xFFF9F9F9), width: 1)),
              )),
        );

      default:
        // return SPPlatform.isIOS()
        //     ? CupertinoTextField(
        //         controller: this.widget.controller,
        //         obscureText: this.widget.obscureText ?? false,
        //       )
        //     : TextField(
        //         controller: this.widget.controller,
        //         obscureText: this.widget.obscureText ?? false,
        //         decoration: InputDecoration(
        //             prefixIcon: this.widget.prefixIcon,
        //             suffixIcon: this.widget.sufixIcon,
        //             hintText: this.widget.placeholder));

        return Material(
          child: TextField(
              focusNode: focusNode,
              autofocus: this.widget.autofocus,
              controller: this.widget.controller,
              obscureText: this.widget.obscureText ?? false,
              maxLines: this.widget.maxLines,
              textInputAction: this.widget.textInputAction,
              decoration: InputDecoration(
                  prefixIcon: this.widget.prefixIcon,
                  suffixIcon: this.widget.sufixIcon,
                  hintText: this.widget.placeholder)),
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
    super.dispose();
  }
}
