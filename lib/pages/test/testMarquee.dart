import '../../common/controlls/marquee.dart';
import 'package:flutter/material.dart';

class TestMarqueePage extends StatefulWidget {
  @override
  _TestMarqueePageState createState() => _TestMarqueePageState();
}

class _TestMarqueePageState extends State<TestMarqueePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Marquee"),
      ),
      body: Container(
        width: double.infinity,
        child: Container(
          color: Colors.yellow,
          child: SizedBox(
            height: 20,
            child: SPMarquee(
              text:
                  "As the documentation says this error occurs due to the nesting of the same kind of",
            ),
          ),
        ),
      ),
    );
  }
}
