import 'package:flutter/cupertino.dart';

enum SPSPSearchTextFieldPattern { normal }

class SPSearchTextField extends StatefulWidget {
  final TextEditingController? controller;
  final SPSPSearchTextFieldPattern? pattern;

  /// Invoked upon user input.
  final ValueChanged<String>? onChanged;

  /// Invoked upon keyboard submission.
  final ValueChanged<String>? onSubmitted;

  SPSearchTextField(
      {this.pattern, this.controller, this.onChanged, this.onSubmitted});

  @override
  _SPSearchTextFieldState createState() => _SPSearchTextFieldState();
}

class _SPSearchTextFieldState extends State<SPSearchTextField> {
  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
        controller: this.widget.controller,
        onChanged: this.widget.onChanged,
        onSubmitted: this.widget.onSubmitted);
  }
}
