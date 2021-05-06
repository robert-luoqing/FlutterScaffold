import '../../common/controlls/dialog.dart';
import '../../common/controlls/switch.dart';
import 'package:flutter/material.dart';

class TestSwitchControl extends StatefulWidget {
  @override
  _TestSwitchControlState createState() => _TestSwitchControlState();
}

class _TestSwitchControlState extends State<TestSwitchControl> {
  bool _switchValue = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Test switch control")),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SPSwitch(
                value: _switchValue,
                onChanged: (bool val) {
                  setState(() {
                    _switchValue = val;
                  });
                  SPDialog.alert(context, "The switchValue is $_switchValue");
                },
              ),
            ],
          ),
        ));
  }
}
