import 'package:flutter_svg/svg.dart';
import 'package:lingo_dragon/common/constant/colors.dart';
import 'package:lingo_dragon/common/controlls/button.dart';
import 'package:lingo_dragon/common/controlls/picker.dart';
import 'package:lingo_dragon/providers/i18n_provider.dart';
import 'package:lingo_dragon/common/utils/validate_util.dart';
import 'package:lingo_dragon/pages/login/verify_code_page.dart';
import 'package:flutter/services.dart';
import 'package:lingo_dragon/theme/text_style.dart';
import '../../common/controlls/scaffold.dart';
import 'package:flutter/material.dart';
import '../../common/controlls/text_field.dart';
import 'dart:convert';

class PhoneLoginPage extends StatefulWidget {
  const PhoneLoginPage({Key? key}) : super(key: key);

  @override
  _PhoneLoginPageState createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  final telController = TextEditingController();
  String countryCode = '+86';
  bool btnEnable = false;
  bool telFormatWarn = false; // 是否格式警告
  Map<dynamic, dynamic> countryCodeList = {};
  int? selectedValue = 45;

  @override
  void initState() {
    _bulidCountryCode();
    super.initState();
    telController.addListener(_telOnChange);
  }

  void _bulidCountryCode() async {
    var cJson = await rootBundle.loadString('assets/data/countryCode.json');
    List<dynamic> cList = jsonDecode(cJson);
    for (var i = 0; i < cList.length; i++) {
      countryCodeList[i] = cList[i];
    }
  }

  _telOnChange() {
    var nextBtnEnable = telController.text.isNotEmpty;
    if (nextBtnEnable != btnEnable) {
      setState(() {
        btnEnable = nextBtnEnable;
      });
    }
  }

  @override
  void dispose() {
    telController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SPScaffold(
        noStatusBar: true,
        body: Container(
            margin: const EdgeInsets.only(left: 30, right: 30),
            child: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              behavior: HitTestBehavior.opaque,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  navigationBar(),
                  Container(
                    child: Text(SPI18N.of(context).login_button_phone,
                        style: SPTextStyle.text30c1A1C25Style),
                    margin: const EdgeInsets.only(bottom: 15),
                  ),
                  Text(
                    SPI18N.of(context).login_title_phoneNumbe,
                    style: SPTextStyle.text18c1A1C25Style,
                    textAlign: TextAlign.left,
                  ),
                  renderPhoneInput(),
                  telFormatWarn
                      ? Text(
                          SPI18N.of(context).login_hint_phoneFormat,
                          style: SPTextStyle.text12cFB6566Style,
                        )
                      : Container(),
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: SPButton(
                          pattern: SPButtonPattern.animatedButton,
                          size: SPButtonSize.large,
                          onPressed: _continueOnTap,
                          disabled: !btnEnable,
                          text: SPI18N.of(context).common_button_continue))
                ],
              ),
            )));
  }

  Widget navigationBar() {
    return (Align(
        alignment: Alignment.topRight,
        child: Container(
            margin: const EdgeInsets.only(top: 45, bottom: 35),
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                behavior: HitTestBehavior.translucent,
                child: SvgPicture.asset("assets/icons/pageClose.svg")))));
  }

  Widget renderPhoneInput() {
    return (Stack(alignment: Alignment.centerLeft, children: [
      Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: telFormatWarn
                      ? SPColors.warnColor
                      : const Color(0xff5467F0),
                  width: 1,
                  style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(31.5)),
          margin: const EdgeInsets.only(top: 35, bottom: 5),
          height: 50,
          child: Container(
            margin: const EdgeInsets.only(left: 117, right: 20),
            child: SPTextField(
              keyboardType: TextInputType.phone,
              pattern: SPTextFieldPattern.withoutBorder,
              controller: telController,
              autofocus: true,
              isWarnStyle: telFormatWarn,
            ),
          )),
      GestureDetector(
          onTap: _openCountryCodePicker,
          child: Container(
              margin: const EdgeInsets.only(left: 48, top: 30),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/dropDownIcon.svg",
                    color: telFormatWarn
                        ? SPColors.warnColor
                        : const Color(0xff1A1C25),
                  ),
                  Text(
                    countryCode,
                    style: telFormatWarn
                        ? SPTextStyle.text16cFB6566Style
                        : SPTextStyle.text16c1A1C25Style,
                  )
                ],
              ))),
      Container(
          margin: const EdgeInsets.only(left: 24, top: 30),
          child: SvgPicture.asset(
            "assets/icons/phoneIcon.svg",
            color: telFormatWarn ? SPColors.warnColor : const Color(0xff5467F0),
          )),
      Container(
        margin: const EdgeInsets.only(left: 116, top: 30),
        child: const SizedBox(
          width: 1,
          height: 18,
          child: DecoratedBox(
            decoration: BoxDecoration(color: Color(0xffDDDCE2)),
          ),
        ),
      )
    ]));
  }

  _openCountryCodePicker(
      {bool showTopBar = true, bool dismissIsSelect = false}) async {
    if (countryCodeList.isNotEmpty && countryCodeList.isNotEmpty) {
      selectedValue = await SPPicker.show(context, countryCodeList,
          selectedKey: selectedValue,
          showTopBar: showTopBar,
          dismissIsSelect: dismissIsSelect, itemBuilder: (key, val) {
        if (val.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: [
                Expanded(child: Text("${val['countryName']}")),
                Text("+${val['phoneCode']}")
              ],
            ),
          );
        } else {
          return Container();
        }
      });
      if (selectedValue != null) {
        setState(() {
          countryCode = '+ ${countryCodeList[selectedValue]?['phoneCode']}';
        });
      }
    }
  }

  void _continueOnTap() {
    if (ValidateUtil.isTel(telController.text)) {
      sendSMS();
    } else {
      setState(() {
        telFormatWarn = true;
      });
    }
  }

  void sendSMS() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                VerifyCodePage(account: '$countryCode ${telController.text}')));
  }
}
