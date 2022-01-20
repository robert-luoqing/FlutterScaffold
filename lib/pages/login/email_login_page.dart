import 'package:flutter_svg/svg.dart';
import 'package:lingo_dragon/common/constant/colors.dart';
import 'package:lingo_dragon/common/controlls/button.dart';
import 'package:lingo_dragon/providers/i18n_provider.dart';
import 'package:lingo_dragon/common/utils/validate_util.dart';
import 'package:lingo_dragon/pages/login/verify_code_page.dart';
import 'package:lingo_dragon/theme/text_style.dart';
import '../../common/controlls/scaffold.dart';
import 'package:flutter/material.dart';
import '../../common/controlls/text_field.dart';

class EmailLoginPage extends StatefulWidget {
  const EmailLoginPage({Key? key}) : super(key: key);

  @override
  _EmailLoginPageState createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends State<EmailLoginPage> {
  final emailController = TextEditingController();
  bool btnEnable = false;
  bool emailFormatWarn = false; // 是否格式警告
  Map<dynamic, dynamic> countryCodeList = {};

  @override
  void initState() {
    super.initState();
    emailController.addListener(_emailOnChange);
  }

  _emailOnChange() {
    var nextBtnEnable = emailController.text.isNotEmpty;
    if (nextBtnEnable != btnEnable) {
      setState(() {
        btnEnable = nextBtnEnable;
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
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
                    child: Text(SPI18N.of(context).login_button_email,
                        style: SPTextStyle.text30c1A1C25Style),
                    margin: const EdgeInsets.only(bottom: 15),
                  ),
                  Text(
                    SPI18N.of(context).login_title_emailAddress,
                    style: SPTextStyle.text18c1A1C25Style,
                    textAlign: TextAlign.left,
                  ),
                  renderEmailInput(),
                  emailFormatWarn
                      ? Text(
                          SPI18N.of(context).login_hint_emailFormat,
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
                          text: SPI18N.of(context).common_button_continue)),
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

  Widget renderEmailInput() {
    return (Stack(alignment: Alignment.centerLeft, children: [
      Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: emailFormatWarn
                      ? SPColors.warnColor
                      : const Color(0xff5467F0),
                  width: 1,
                  style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(31.5)),
          margin: const EdgeInsets.only(top: 35, bottom: 5),
          height: 50,
          child: Container(
            margin: const EdgeInsets.only(left: 45, right: 20),
            child: SPTextField(
              keyboardType: TextInputType.emailAddress,
              pattern: SPTextFieldPattern.withoutBorder,
              controller: emailController,
              autofocus: true,
              isWarnStyle: emailFormatWarn,
            ),
          )),
      Container(
          margin: const EdgeInsets.only(left: 24, top: 30),
          child: SvgPicture.asset("assets/icons/emailIcon.svg",
              color: emailFormatWarn
                  ? SPColors.warnColor
                  : const Color(0xff5467F0))),
    ]));
  }

  void _continueOnTap() {
    if (ValidateUtil.isEmail(emailController.text)) {
      sendSMS();
    } else {
      setState(() {
        emailFormatWarn = true;
      });
    }
  }

  void sendSMS() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                VerifyCodePage(account: emailController.text)));
  }
}
