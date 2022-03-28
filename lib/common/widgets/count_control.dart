import 'dart:async';

import 'package:flutter/material.dart';

class SPCountControl extends StatefulWidget {
  final int durationSeconds;
  final Widget? prefixText;
  final Widget? sufixText;
  final TextStyle? textStyle;
  final VoidCallback? onFinished;
  const SPCountControl(
      {Key? key,
      required this.durationSeconds,
      this.prefixText,
      this.sufixText,
      this.textStyle,
      this.onFinished})
      : super(key: key);

  @override
  SPCountControlState createState() => SPCountControlState();
}

class SPCountControlState extends State<SPCountControl> {
  Timer? _stopTimer;
  late int remainSendSMSTime = 0;
  startCount() {
    if (_stopTimer != null) {
      _stopTimer!.cancel();
      _stopTimer = null;
    }
    setState(() {
      remainSendSMSTime = widget.durationSeconds;
      _stopTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (remainSendSMSTime > 0) {
          setState(() {
            remainSendSMSTime--;
          });
        } else {
          if (widget.onFinished != null) {
            widget.onFinished!();
          }
        }
      });
    });
  }

  endCount() {
    if (_stopTimer != null) {
      _stopTimer!.cancel();
      _stopTimer = null;
    }
  }

  @override
  void initState() {
    startCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    if (widget.prefixText != null) {
      children.add(widget.prefixText!);
    }
    children.add(Text(
      remainSendSMSTime.toString(),
      style: widget.textStyle,
    ));
    if (widget.sufixText != null) {
      children.add(widget.sufixText!);
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  @override
  void dispose() {
    if (_stopTimer != null) {
      _stopTimer!.cancel();
    }
    super.dispose();
  }
}
