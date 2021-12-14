import '../../../common/utils/platformUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SPSlider extends StatefulWidget {
  final double value;
  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onChangeStart;
  final ValueChanged<double>? onChangeEnd;
  final double min;
  final double max;

  SPSlider({
    required this.value,
    required this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0.0,
    this.max = 1.0,
  });
  @override
  _SPSliderState createState() => _SPSliderState();
}

class _SPSliderState extends State<SPSlider> {
  @override
  Widget build(BuildContext context) {
    return SPPlatform.isIOS()
        ? CupertinoSlider(
            value: this.widget.value,
            onChanged: this.widget.onChanged,
            onChangeStart: this.widget.onChangeStart,
            onChangeEnd: this.widget.onChangeEnd,
            min: this.widget.min,
            max: this.widget.max,
          )
        : Slider(
            value: this.widget.value,
            onChanged: this.widget.onChanged,
            onChangeStart: this.widget.onChangeStart,
            onChangeEnd: this.widget.onChangeEnd,
            min: this.widget.min,
            max: this.widget.max,
          );
  }
}
