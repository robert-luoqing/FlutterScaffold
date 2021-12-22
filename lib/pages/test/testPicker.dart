import 'package:FlutterScaffold/common/controlls/dialog.dart';
import 'package:FlutterScaffold/common/controlls/picker.dart';
import 'package:FlutterScaffold/common/controlls/scaffold.dart';
import 'package:flutter/material.dart';

class TestPicker extends StatefulWidget {
  const TestPicker({Key? key}) : super(key: key);

  @override
  _TestPickerState createState() => _TestPickerState();
}

class _TestPickerState extends State<TestPicker> {
  final list = {1: "First", 2: "Second", 3: "Third"};
  int? selectedValue = 2;
  _openPicker({bool showTopBar = true, bool dismissIsSelect = false}) async {
    this.selectedValue = await SPPicker.show(context, list,
        selectedKey: this.selectedValue,
        showTopBar: showTopBar,
        dismissIsSelect: dismissIsSelect);
    SPDialog.alert(context, "Selected: $selectedValue");
  }

  @override
  Widget build(BuildContext context) {
    return SPScaffold(
      title: Text("Text Picker"),
      body: Container(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  _openPicker();
                },
                child: Text("Test Picker")),
            ElevatedButton(
                onPressed: () {
                  _openPicker(showTopBar: false);
                },
                child: Text("Test Picker Without toolbar")),
            ElevatedButton(
                onPressed: () {
                  _openPicker(showTopBar: false, dismissIsSelect: true);
                },
                child: Text("Test Picker DismissIsSelect")),
          ],
        ),
      ),
    );
  }
}
