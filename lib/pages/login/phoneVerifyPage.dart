import 'dart:async';
import 'package:FlutterScaffold/pages/test/testPinCode.dart';
import '../../common/controlls/scaffold.dart';
import 'package:flutter/material.dart';

class VerifyCodePage extends StatefulWidget {
  VerifyCodePage({
    Key? key,
    required this.phone,
  }) : super(key: key);
  final String phone;
  @override
  _VerifyCodePageState createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  final codeController = TextEditingController();
  int remainingTime = 0; // 可重发验证码的剩余时间（秒）
  late Timer _timer;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SPScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          renderHeader(),
          TestPinCode(),
          renderBtn(),
        ],
      ),
    );
  }

  Widget renderHeader() {
    return (Container(
      margin: EdgeInsets.only(top: 40, left: 40, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text('Log in', style: TextStyle(fontSize: 18))),
          Text(
              'Please enter the verification code sent to ${this.widget.phone}',
              style: TextStyle(fontSize: 14))
        ],
      ),
    ));
  }

  Widget renderBtn() {
    String timesString = remainingTime <= 0 ? '' : ' ($remainingTime)';
    return (Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
                color: const Color(0xff5D626D),
                width: 0.5,
                style: BorderStyle.solid)),
        margin: EdgeInsets.only(left: 40, right: 40, top: 30),
        alignment: Alignment.center,
        height: 40,
        child: GestureDetector(
            onTap: _resendOnTap,
            child: Container(
              decoration: BoxDecoration(
                  color: remainingTime <= 0
                      ? Colors.blueAccent
                      : Colors.grey[350]),
              child: Text(
                'Resend $timesString',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Metropolis-Bold'),
                textAlign: TextAlign.center,
                strutStyle: StrutStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  leading: 0,
                  height: 1.1, // 1.1会更居中
                  forceStrutHeight: true, // 强制改为文字高度
                ),
              ),
              alignment: Alignment.center,
            ))));
  }

  void _resendOnTap() {
    if (remainingTime <= 0) {
      _startTimer();
    }
  }
// SPToast.show(context, "Please fill in the blank");

  // 启动Timer
  void _startTimer() {
    final Duration duration = Duration(seconds: 1);
    // _timer.cancel(); // 取消Timer
    setState(() {
      remainingTime = 10;
    });
    _timer = Timer.periodic(duration, (timer) {
      setState(() {
        remainingTime = remainingTime - 1;
      });
      // print(remainingTime);
      if (remainingTime <= 0) {
        _timer.cancel();
      }
    });
  }
}
