import 'package:flutter/material.dart';

class SPSwitch extends StatefulWidget {
  final ValueChanged<bool>? onChanged;
  final bool value;

  SPSwitch({required this.value, this.onChanged});

  @override
  _SPSwitchState createState() => _SPSwitchState();
}

class _SPSwitchState extends State<SPSwitch> {
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: this.widget.value,
      onChanged: (bool val) {
        if (this.widget.onChanged != null) {
          this.widget.onChanged!(val);
        }
      },
    );
  }
}
