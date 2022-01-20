import 'package:lingo_dragon/common/controlls/pin_code.dart';
import 'package:lingo_dragon/providers/i18n_provider.dart';
import 'package:lingo_dragon/pages/login/timer.dart';
import 'package:lingo_dragon/theme/text_style.dart';
import '../../common/controlls/scaffold.dart';
import 'package:flutter/material.dart';

class VerifyCodePage extends StatefulWidget {
  const VerifyCodePage({
    Key? key,
    required this.account,
  }) : super(key: key);
  final String account;
  @override
  _VerifyCodePageState createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  final codeController = TextEditingController();
  int errorTimes = 0;
  bool isTiming = true; // 是否正在计时
  int timeDuration = 60; // 重发验证码的间隔时长
  int resendCount = 4; // 可重发验证码的次数
  @override
  Widget build(BuildContext context) {
    return SPScaffold(
        body: Container(
            margin: const EdgeInsets.only(left: 30, right: 30, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Text(SPI18N.of(context).login_title_login,
                      style: SPTextStyle.text30c1A1C25Style),
                  margin: const EdgeInsets.only(bottom: 15),
                ),
                renderHeader(),
                Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: SPPinCode(
                      length: 6,
                      onCompleted: (String text) {
                        setState(() {
                          errorTimes = errorTimes + 1;
                        });
                      },
                      errorTimes: errorTimes,
                    )),
                Center(child: renderResend()),
              ],
            )));
  }

  Widget renderHeader() {
    return (Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(SPI18N.of(context).login_text_verificationSent,
              style: SPTextStyle.text14c979FA8Style),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Text(widget.account, style: SPTextStyle.text16c1A1C25Style),
          )
        ],
      ),
    ));
  }

  Widget renderResend() {
    if (isTiming) {
      return (Container(
        height: 20,
        width: 35,
        decoration: BoxDecoration(
            border: Border.all(
                color: const Color(0xff979FA8),
                width: 1,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: TimerComponent(
                duration: timeDuration, timeOutCallback: _timeOut)),
      ));
    } else {
      return (Column(children: [
        Container(
          child: Text(SPI18N.of(context).login_text_resend,
              style: SPTextStyle.text12c979FA8Style),
          margin: const EdgeInsets.only(top: 10),
          height: 20,
        ),
        GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _resendOnTap,
            child: Text(SPI18N.of(context).login_button_resend,
                style: SPTextStyle.text12c1C8DFEStyle)),
      ]));
    }
  }

  void _resendOnTap() {
    setState(() {
      isTiming = true;
      resendCount = resendCount - 1;
    });
  }

  void _timeOut() {
    int duration = resendCount <= 1 ? 600 : timeDuration; // 获取第5个验证码需要间隔10min
    setState(() {
      isTiming = false;
      timeDuration = duration;
    });
  }
}
