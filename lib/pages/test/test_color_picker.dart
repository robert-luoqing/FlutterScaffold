import 'package:flutter/material.dart';
import 'package:lingo_dragon/common/widgets/color_picker.dart';
import 'package:lingo_dragon/common/widgets/dialog.dart';
import 'package:lingo_dragon/common/widgets/scaffold.dart';

class TestColorPicker extends StatefulWidget {
  const TestColorPicker({Key? key}) : super(key: key);

  @override
  State<TestColorPicker> createState() => _TestColorPickerState();
}

class _TestColorPickerState extends State<TestColorPicker> {
  Color _selectedColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return SPScaffold(
        title: const Text("Dialog"),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,

          children: [
            ElevatedButton(
                onPressed: () async {
                  Color? color = await SPColorPicker.show(context, initColor: _selectedColor);
                  if (color != null) {
                    _selectedColor = color;
                    SPDialog.alert(context, "Color：${color.toString()}");
                  } else {
                    SPDialog.alert(context, "No color selected");
                  }
                },
                child: const Text("Picker Color")),
          ],
        ));
  }
}
