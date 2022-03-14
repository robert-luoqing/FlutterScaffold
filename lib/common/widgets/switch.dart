import '../utils/platform_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SPSwitch extends StatefulWidget {
  final ValueChanged<bool>? onChanged;
  final bool value;

  const SPSwitch({Key? key, required this.value, this.onChanged})
      : super(key: key);

  @override
  _SPSwitchState createState() => _SPSwitchState();
}

class _SPSwitchState extends State<SPSwitch> {
  Widget _buildIOWidget() {
    return CupertinoSwitch(
      value: widget.value,
      onChanged: (bool val) {
        if (widget.onChanged != null) {
          widget.onChanged!(val);
        }
      },
    );
  }

  Widget _buildAndroidWidget() {
    return SizedBox(
      child: Switch(
        value: widget.value,
        onChanged: (bool val) {
          if (widget.onChanged != null) {
            widget.onChanged!(val);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SPPlatform.isIOS() ? _buildIOWidget() : _buildAndroidWidget();
  }
}
