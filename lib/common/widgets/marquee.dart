import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class SPMarquee extends StatefulWidget {
  final String? text;
  const SPMarquee({Key? key, this.text}) : super(key: key);

  @override
  _SPMarqueeState createState() => _SPMarqueeState();
}

class _SPMarqueeState extends State<SPMarquee> {
  @override
  Widget build(BuildContext context) {
    return Marquee(
      text: widget.text ?? "",
      style: const TextStyle(fontWeight: FontWeight.bold),
      scrollAxis: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      blankSpace: 20.0,
      velocity: 100.0,
      pauseAfterRound: const Duration(seconds: 1),
      startPadding: 10.0,
      accelerationDuration: const Duration(seconds: 1),
      accelerationCurve: Curves.linear,
      decelerationDuration: const Duration(milliseconds: 500),
      decelerationCurve: Curves.easeOut,
    );
  }
}
