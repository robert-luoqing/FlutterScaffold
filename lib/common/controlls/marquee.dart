import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class SPMarquee extends StatefulWidget {
  @override
  _SPMarqueeState createState() => _SPMarqueeState();
  final String? text;
  SPMarquee({this.text});
}

class _SPMarqueeState extends State<SPMarquee> {
  @override
  Widget build(BuildContext context) {
    return Marquee(
      text: this.widget.text ?? "",
      style: TextStyle(fontWeight: FontWeight.bold),
      scrollAxis: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      blankSpace: 20.0,
      velocity: 100.0,
      pauseAfterRound: Duration(seconds: 1),
      startPadding: 10.0,
      accelerationDuration: Duration(seconds: 1),
      accelerationCurve: Curves.linear,
      decelerationDuration: Duration(milliseconds: 500),
      decelerationCurve: Curves.easeOut,
    );
  }
}
