import '../utils/platform_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SPSlider extends StatefulWidget {
  final double value;
  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onChangeStart;
  final ValueChanged<double>? onChangeEnd;
  final double min;
  final double max;

  const SPSlider({
    Key? key,
    required this.value,
    required this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0.0,
    this.max = 1.0,
  }) : super(key: key);
  @override
  _SPSliderState createState() => _SPSliderState();
}

class _SPSliderState extends State<SPSlider> {
  @override
  Widget build(BuildContext context) {
    return SPPlatform.isIOS()
        ? CupertinoSlider(
            value: widget.value,
            onChanged: widget.onChanged,
            onChangeStart: widget.onChangeStart,
            onChangeEnd: widget.onChangeEnd,
            min: widget.min,
            max: widget.max,
          )
        : Slider(
            value: widget.value,
            onChanged: widget.onChanged,
            onChangeStart: widget.onChangeStart,
            onChangeEnd: widget.onChangeEnd,
            min: widget.min,
            max: widget.max,
          );
  }
}
