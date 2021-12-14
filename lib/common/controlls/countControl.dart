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
      this.remainSendSMSTime = this.widget.durationSeconds;
      _stopTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (remainSendSMSTime > 0) {
          this.setState(() {
            remainSendSMSTime--;
          });
        } else {
          if (this.widget.onFinished != null) {
            this.widget.onFinished!();
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
    this.startCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    if (this.widget.prefixText != null) {
      children.add(this.widget.prefixText!);
    }
    children.add(Text(
      this.remainSendSMSTime.toString(),
      style: this.widget.textStyle,
    ));
    if (this.widget.sufixText != null) {
      children.add(this.widget.sufixText!);
    }
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
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
