/**
 * The class will wrap text field and its styles.
 * Principle: Don't expose complicate style to invoker
 * Just make invoker simple ASAP to reduce complex in page or component
 * The style will be finished in cocrect work in project or coming from UX team
 */

import 'package:flutter/material.dart';

enum SPTextFieldPattern { normal }

class SPTextField extends StatefulWidget {
  final TextEditingController? controller;
  final SPTextFieldPattern? pattern;
  SPTextField({this.pattern, this.controller});

  @override
  _SPTextFieldState createState() => _SPTextFieldState();
}

class _SPTextFieldState extends State<SPTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(controller: this.widget.controller);
  }
}
