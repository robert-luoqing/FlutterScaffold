import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class TestPinCode extends StatefulWidget {
  const TestPinCode({Key? key}) : super(key: key);

  @override
  _TestPinCodeState createState() => _TestPinCodeState();
}

class _TestPinCodeState extends State<TestPinCode> {
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 40, right: 40),
      child: Center(
          child: PinCodeTextField(
        cursorColor: Colors.transparent,
        length: 6,
        obscureText: false,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 40,
          fieldWidth: 35,
          activeFillColor: Colors.white,
        ),
        animationDuration: const Duration(milliseconds: 200),
        enableActiveFill: false,
        controller: textEditingController,
        onCompleted: (v) {},
        onChanged: (value) {
          setState(() {
            currentText = value;
          });
        },
        beforeTextPaste: (text) {
          return true;
        },
        appContext: context,
      )),
    );
  }
}
