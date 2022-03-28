import '../../common/widgets/datetime_picker.dart';
import '../../common/widgets/dialog.dart';
import 'package:flutter/material.dart';

class TestDateTimePicker extends StatefulWidget {
  const TestDateTimePicker({Key? key}) : super(key: key);

  @override
  _TestDateTimePickerState createState() => _TestDateTimePickerState();
}

class _TestDateTimePickerState extends State<TestDateTimePicker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Dialog")),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,

          children: [
            ElevatedButton(
                onPressed: () async {
                  var selectredDate = await SPDateTimePicker.showDatePicker(
                      context, onConfirm: (date) {
                    // SPDialog.alert(context, "$date");
                  });

                  SPDialog.alert(context, "$selectredDate");
                },
                child: const Text("Open Date Picker")),
            ElevatedButton(
                onPressed: () async {
                  var selectredDate = await SPDateTimePicker.showTimePicker(
                      context,
                      onConfirm: (date) {});
                  SPDialog.alert(context, "$selectredDate");
                },
                child: const Text("Open Time Picker")),
            ElevatedButton(
                onPressed: () async {
                  var selectredDate = await SPDateTimePicker.showDateTimePicker(
                      context,
                      onConfirm: (date) {});
                  SPDialog.alert(context, "$selectredDate");
                },
                child: const Text("Open DateTime Picker")),
          ],
        ));
  }
}
