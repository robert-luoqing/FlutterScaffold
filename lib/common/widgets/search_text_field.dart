import 'package:flutter/cupertino.dart';

enum SPSPSearchTextFieldPattern { normal }

class SPSearchTextField extends StatefulWidget {
  final TextEditingController? controller;
  final SPSPSearchTextFieldPattern? pattern;

  /// Invoked upon user input.
  final ValueChanged<String>? onChanged;

  /// Invoked upon keyboard submission.
  final ValueChanged<String>? onSubmitted;

  const SPSearchTextField(
      {Key? key,
      this.pattern,
      this.controller,
      this.onChanged,
      this.onSubmitted})
      : super(key: key);

  @override
  _SPSearchTextFieldState createState() => _SPSearchTextFieldState();
}

class _SPSearchTextFieldState extends State<SPSearchTextField> {
  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted);
  }
}
