import 'dart:async';
import 'package:lingo_dragon/theme/text_style.dart';
import 'package:flutter/material.dart';

class TimerComponent extends StatefulWidget {
  final int duration;
  final Function? timeOutCallback;
  const TimerComponent({
    Key? key,
    required this.duration, // 计时时长 s
    this.timeOutCallback, // 计时结束的回调
  }) : super(key: key);

  @override
  _TimerComponentState createState() => _TimerComponentState();
}

class _TimerComponentState extends State<TimerComponent> {
  int remainingTime = 0; // 剩余时间 s
  late Timer _timer;
  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String timesString = remainingTime <= 0 ? '' : '$remainingTime' 's';
    return (Text(timesString, style: SPTextStyle.text12c979FA8Style));
  }

  void _startTimer() {
    const Duration duration = Duration(seconds: 1);
    setState(() {
      remainingTime = widget.duration;
    });
    _timer = Timer.periodic(duration, (timer) {
      setState(() {
        remainingTime = remainingTime - 1;
      });
      if (remainingTime <= 0) {
        _timer.cancel();
        if (widget.timeOutCallback != null) {
          widget.timeOutCallback!();
        }
      }
    });
  }
}
