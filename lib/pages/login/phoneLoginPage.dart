import 'package:FlutterScaffold/common/controlls/toast.dart';
import 'package:FlutterScaffold/pages/login/phoneVerifyPage.dart';
import '../../common/controlls/scaffold.dart';
import 'package:flutter/material.dart';
import '../../common/controlls/textField.dart';

class PhoneLoginPage extends StatefulWidget {
  @override
  _PhoneLoginPageState createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  final telController = TextEditingController();
  String countryCode = '+86';
  bool btnEnable = false;
  @override
  void initState() {
    super.initState();
  }

  bool _checkTel() {
    String regexTelNumber =
        "^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$";
    return RegExp(regexTelNumber).hasMatch(telController.text);
  }

  @override
  void dispose() {
    telController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SPScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          renderHeader(),
          renderCountryCode(),
          renderPhoneInput(),
          renderBtn(),
        ],
      ),
    );
  }

  Widget renderHeader() {
    return (Container(
      margin: EdgeInsets.only(top: 40, left: 40),
      child: Text(
        'What’s your phone number?',
        style: TextStyle(fontSize: 16),
        textAlign: TextAlign.left,
      ),
    ));
  }

  Widget renderCountryCode() {
    return (Stack(alignment: Alignment.center, children: [
      GestureDetector(
          onTap: _codeOnTap,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                    color: const Color(0xff5D626D),
                    width: 1,
                    style: BorderStyle.solid)),
            padding: EdgeInsets.only(left: 20, right: 20, top: 15),
            margin: EdgeInsets.only(left: 40, right: 40, bottom: 20, top: 20),
            height: 50,
            child: Text(
              this.countryCode,
              style: TextStyle(color: Colors.grey[400], fontSize: 14),
            ),
          ))
    ]));
  }

  Widget renderPhoneInput() {
    return (Stack(alignment: Alignment.center, children: [
      Container(
        decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
                color: const Color(0xff5D626D),
                width: 1,
                style: BorderStyle.solid)),
        padding: EdgeInsets.only(left: 15, right: 15),
        margin: EdgeInsets.only(left: 40, right: 40, bottom: 20),
        height: 50,
        child: SPTextField(
          pattern: SPTextFieldPattern.withoutBorder,
          placeholder: 'Enter your phone',
          controller: telController,
        ),
      )
    ]));
  }

  Widget renderBtn() {
    return (Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
                color: const Color(0xff5D626D),
                width: 0.5,
                style: BorderStyle.solid)),
        margin: EdgeInsets.all(40),
        alignment: Alignment.center,
        height: 40,
        child: GestureDetector(
            onTap: _nextOnTap,
            child: Container(
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Text(
                'Continue',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Metropolis-Bold'),
                textAlign: TextAlign.center,
                strutStyle: StrutStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  leading: 0,
                  height: 1.1, // 1.1会更居中
                  forceStrutHeight: true, // 强制改为文字高度
                ),
              ),
              alignment: Alignment.center,
            ))));
  }

  void _codeOnTap() {
    Navigator.pushNamed(context, "/alphabetListView").then((value) => {
          setState(() {
            countryCode = '+' + '$value';
          })
        });
  }

  void _nextOnTap() {
    if (telController.text.isNotEmpty) {
      if (!_checkTel()) {
        SPToast.show(context, "Your phone format is incorrect.");
      } else {
        sendSMS();
      }
    } else {
      SPToast.show(context, "Please fill in the blank");
    }
  }

  void sendSMS() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                VerifyCodePage(phone: '$countryCode ${telController.text}')));
  }
}
