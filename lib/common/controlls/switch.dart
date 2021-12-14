import '../../../common/utils/platformUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SPSwitch extends StatefulWidget {
  final ValueChanged<bool>? onChanged;
  final bool value;

  SPSwitch({required this.value, this.onChanged});

  @override
  _SPSwitchState createState() => _SPSwitchState();
}

class _SPSwitchState extends State<SPSwitch> {
  Widget _buildIOWidget() {
    return CupertinoSwitch(
      value: this.widget.value,
      onChanged: (bool val) {
        if (this.widget.onChanged != null) {
          this.widget.onChanged!(val);
        }
      },
    );
  }

  Widget _buildAndroidWidget() {
    return SizedBox(
      child: Switch(
        value: this.widget.value,
        onChanged: (bool val) {
          if (this.widget.onChanged != null) {
            this.widget.onChanged!(val);
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
