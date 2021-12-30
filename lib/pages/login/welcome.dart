import '../../common/controlls/scaffold.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final psdController = TextEditingController();
  final againPsdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        renderHeader(),
        renderLoginModule(),
        renderTip(),
      ],
    );
  }

  Widget renderHeader() {
    return (Container(
        child: Text(
          'Welcome',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        margin: EdgeInsets.only(bottom: 180)));
  }

  Widget renderLoginModule() {
    return (Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: renderBtn('Continue with Google', _loginOnTap),
          width: 250,
          margin: EdgeInsets.only(bottom: 30),
        ),
        Container(
          child: renderBtn('Continue with Apple', _loginOnTap),
          width: 250,
          margin: EdgeInsets.only(bottom: 30),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: renderBtn('Phone', _phoneOnTap),
              width: 95,
              margin: EdgeInsets.only(right: 60),
            ),
            Container(
              child: renderBtn('Email', _loginOnTap),
              width: 95,
            )
          ],
        )
      ],
    ));
  }

  Widget renderBtn(String text, Function() tap) {
    return (Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
                color: const Color(0xff5D626D),
                width: 1,
                style: BorderStyle.solid)),
        // margin: EdgeInsets.only(left: 40, right: 40, top: 30),
        alignment: Alignment.center,
        height: 40,
        child: GestureDetector(
            onTap: tap,
            child: Container(
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Text(
                text,
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

  Widget renderTip() {
    return (Container(
      margin: EdgeInsets.only(left: 40, right: 40, top: 80),
      child: Text(
        'By proceeding, I accept the Terms and Conditions and the Privacy Policy',
        style: TextStyle(fontSize: 12),
        textAlign: TextAlign.center,
      ),
    ));
  }

  void _phoneOnTap() {
    Navigator.pushNamed(context, "/phoneLogin");
  }

  void _loginOnTap() {}
}
