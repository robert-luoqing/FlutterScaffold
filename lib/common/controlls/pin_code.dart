import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lingo_dragon/common/controlls/pin_code_field/pin_code_fields.dart';
import 'package:lingo_dragon/theme/text_style.dart';

class SPPinCode extends StatefulWidget {
  final int length;
  final void Function(String)? onCompleted;

  /// 由于需要保证连续两次都是错误的情况下也能触发错误动画并且其他的原因引起更新的不触发动画，使用errorTimes代替isError
  final int errorTimes;
  const SPPinCode({
    Key? key,
    required this.length,
    required this.onCompleted,
    required this.errorTimes,
  }) : super(key: key);

  @override
  _SPPinCodeState createState() => _SPPinCodeState();
}

class _SPPinCodeState extends State<SPPinCode> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  String currentText = "";

  @override
  void didUpdateWidget(covariant SPPinCode oldWidget) {
    if (widget.errorTimes != oldWidget.errorTimes) {
      errorController
          .add(ErrorAnimationType.shake); // This will shake the pin code field
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: PinCodeTextField(
      length: widget.length,
      keyboardType: TextInputType.number,
      obscureText: false,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(15),
        fieldHeight: 56,
        fieldWidth: 45,
        inactiveColor: const Color(0xFFDDDCE2),
        selectedColor: const Color(0xFF5467F0),
        activeColor: const Color(0xFFDDDCE2),
        activeFillColor: Colors.white,
        errorBorderColor: const Color(0xFFFB6566),
        errorTextStyle: SPTextStyle.text20cFB6566DINBoldStyle,
        borderWidth: 1,
        selectedBoxShadow: [
          const BoxShadow(
            color: Color(0x405467f0),
            offset: Offset(
              4.0,
              9.0,
            ),
            blurRadius: 20.0,
          ),
          const BoxShadow(
            color: Colors.white,
            offset: Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ),
        ],
        selectedTextStyle: SPTextStyle.text20c5467F0DINBoldStyle,
      ),
      textStyle: SPTextStyle.text20c1A1C25DINBoldStyle,
      animationDuration: const Duration(milliseconds: 200),
      enableActiveFill: false,
      showCursor: true,
      cursorColor: const Color(0xFF5467F0),
      cursorHeight: 20,
      controller: textEditingController,
      onCompleted: widget.onCompleted,
      errorAnimationController: errorController,
      onChanged: (value) {
        setState(() {
          currentText = value;
        });
      },
      beforeTextPaste: (text) {
        return true;
      },
      appContext: context,
    ));
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }
}
