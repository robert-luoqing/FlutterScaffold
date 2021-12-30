import 'package:FlutterScaffold/common/controlls/picker.dart';
import 'package:FlutterScaffold/common/controlls/toast.dart';
import 'package:FlutterScaffold/pages/login/phoneVerifyPage.dart';
import 'package:flutter/services.dart';
import '../../common/controlls/scaffold.dart';
import 'package:flutter/material.dart';
import '../../common/controlls/textField.dart';
import 'dart:convert';

class PhoneLoginPage extends StatefulWidget {
  @override
  _PhoneLoginPageState createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  final telController = TextEditingController();
  String countryCode = '+86';
  bool btnEnable = false;
  Map<dynamic, dynamic> countryCodeList = {};
  int? selectedValue = 45;

  @override
  void initState() {
    _bulidCountryCode();
    super.initState();
  }

  void _bulidCountryCode() async {
    var cJson = await rootBundle.loadString('assets/data/countryCode.json');
    List<dynamic> cList = jsonDecode(cJson);
    for (var i = 0; i < cList.length; i++) {
      countryCodeList[i] = cList[i];
    }
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
          renderPhone(),
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

  Widget renderPhone() {
    return (Stack(alignment: Alignment.centerLeft, children: [
      Container(
          decoration: new UnderlineTabIndicator(
              borderSide: BorderSide(width: 1.0, color: Color(0xff5D626D)),
              insets: EdgeInsets.only(top: 10)),
          margin: EdgeInsets.only(left: 40, right: 40),
          child: Container(
            margin: EdgeInsets.only(left: 60, bottom: 1),
            child: SPTextField(
              pattern: SPTextFieldPattern.withoutBorder,
              placeholder: 'Phone',
              controller: telController,
              autofocus: true,
            ),
          )),
      GestureDetector(
          onTap: _openCountryCodePicker,
          child: Container(
              width: 60,
              margin: EdgeInsets.only(left: 50),
              child: Text(
                countryCode,
                style: TextStyle(fontSize: 16),
              ))),
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

  _openCountryCodePicker(
      {bool showTopBar = true, bool dismissIsSelect = false}) async {
    if (countryCodeList.isNotEmpty && countryCodeList.length > 0) {
      this.selectedValue = await SPPicker.show(context, countryCodeList,
          selectedKey: this.selectedValue,
          showTopBar: showTopBar,
          dismissIsSelect: dismissIsSelect, itemBuilder: (key, val) {
        if (val.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: [
                Image.asset('assets/icons/country.png'),
                Expanded(child: Center(child: Text("${val['countryName']}"))),
                Text("+${val['phoneCode']}")
              ],
            ),
          );
        } else {
          return Container();
        }
      });
      setState(() {
        countryCode = '+ ${countryCodeList[selectedValue]?['phoneCode']}';
      });
    }
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
