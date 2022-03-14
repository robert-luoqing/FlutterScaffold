import 'package:lingo_dragon/common/widgets/dialog.dart';
import 'package:lingo_dragon/common/widgets/picker.dart';
import 'package:lingo_dragon/common/widgets/scaffold.dart';
import 'package:flutter/material.dart';

class TestPicker extends StatefulWidget {
  const TestPicker({Key? key}) : super(key: key);

  @override
  _TestPickerState createState() => _TestPickerState();
}

class _TestPickerState extends State<TestPicker> {
  Map<num, String> list = {};
  int? selectedValue = 2;

  @override
  void initState() {
    for (var i = 0; i < 1000; i++) {
      list[i] = "Item $i";
    }
    super.initState();
  }

  _openPicker({bool showTopBar = true, bool dismissIsSelect = false}) async {
    selectedValue = await SPPicker.show(context, list,
        selectedKey: selectedValue,
        showTopBar: showTopBar,
        dismissIsSelect: dismissIsSelect);
    SPDialog.alert(context, "Selected: $selectedValue");
  }

  _openComplexPicker(
      {bool showTopBar = true, bool dismissIsSelect = false}) async {
    selectedValue = await SPPicker.show(context, list,
        selectedKey: selectedValue,
        showTopBar: showTopBar,
        dismissIsSelect: dismissIsSelect, itemBuilder: (key, val) {
      // print("-------->$key");
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Row(
          children: [
            const Icon(Icons.accessible_forward_outlined),
            Expanded(
                child: Center(
                    child: Text("$val",
                        style: const TextStyle(color: Colors.blue)))),
            const Text(
              "012",
              style: TextStyle(color: Colors.amber),
            )
          ],
        ),
      );
    });
    SPDialog.alert(context, "Selected: $selectedValue");
  }

  @override
  Widget build(BuildContext context) {
    return SPScaffold(
      title: const Text("Text Picker"),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                _openPicker();
              },
              child: const Text("Test Picker")),
          ElevatedButton(
              onPressed: () {
                _openPicker(showTopBar: false);
              },
              child: const Text("Test Picker Without toolbar")),
          ElevatedButton(
              onPressed: () {
                _openPicker(showTopBar: false, dismissIsSelect: true);
              },
              child: const Text("Test Picker DismissIsSelect")),
          ElevatedButton(
              onPressed: () {
                _openComplexPicker(showTopBar: false, dismissIsSelect: true);
              },
              child: const Text("Test Complex Picker")),
        ],
      ),
    );
  }
}
