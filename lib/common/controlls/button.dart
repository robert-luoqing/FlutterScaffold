import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum SPButtonPattern {
  normal,
}

class SPButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final SPButtonPattern pattern;
  final String? text;

  SPButton({required this.pattern, required this.text, this.onPressed});
  @override
  _SPButtonState createState() => _SPButtonState();
}

class _SPButtonState extends State<SPButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(this.widget.text ?? ""),
    );
  }
}
