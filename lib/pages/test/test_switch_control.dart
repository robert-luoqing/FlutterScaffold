import '../../common/widgets/dialog.dart';
import '../../common/widgets/switch.dart';
import 'package:flutter/material.dart';

class TestSwitchControl extends StatefulWidget {
  const TestSwitchControl({Key? key}) : super(key: key);

  @override
  _TestSwitchControlState createState() => _TestSwitchControlState();
}

class _TestSwitchControlState extends State<TestSwitchControl> {
  bool _switchValue = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Test switch control")),
        body: Column(
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
        ));
  }
}
