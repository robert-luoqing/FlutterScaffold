import 'package:flutter/material.dart';
import 'package:lingo_dragon/common/controlls/transparent_gradient_button.dart';

class TestTransparentGradientButton extends StatefulWidget {
  const TestTransparentGradientButton({Key? key}) : super(key: key);

  @override
  State<TestTransparentGradientButton> createState() =>
      _TestTransparentGradientButtonState();
}

class _TestTransparentGradientButtonState
    extends State<TestTransparentGradientButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/icons/splashImage.png"),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TransparentGradientButton(
                  strokeWidth: 5,
                  radius: 22,
                  borderGradient: const LinearGradient(
                    colors: [Color(0x7710FFF3), Color(0x66FFEB3B)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  backgroundGradient: const LinearGradient(
                      colors: [Color(0x77FF0000), Color(0x774CAF50)]),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('He is test button, please click it',
                        style: TextStyle(fontSize: 16)),
                  ),
                  onPressed: () {
                    debugPrint("-------------------->click");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
