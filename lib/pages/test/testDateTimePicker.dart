import '../../common/controlls/datetimePicker.dart';
import '../../common/controlls/dialog.dart';
import 'package:flutter/material.dart';

class TestDateTimePicker extends StatefulWidget {
  @override
  _TestDateTimePickerState createState() => _TestDateTimePickerState();
}

class _TestDateTimePickerState extends State<TestDateTimePicker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Dialog")),
        body: Container(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,

            children: [
              ElevatedButton(
                  onPressed: () async {
                    SPDateTimePicker.showDatePicker(context, onConfirm: (date) {
                      SPDialog.alert(context, "$date");
                    });
                  },
                  child: Text("Open Date Picker")),
              ElevatedButton(
                  onPressed: () async {
                    SPDateTimePicker.showTimePicker(context, onConfirm: (date) {
                      SPDialog.alert(context, "$date");
                    });
                  },
                  child: Text("Open Time Picker")),
              ElevatedButton(
                  onPressed: () async {
                    SPDateTimePicker.showDateTimePicker(context,
                        onConfirm: (date) {
                      SPDialog.alert(context, "$date");
                    });
                  },
                  child: Text("Open DateTime Picker")),
            ],
          ),
        ));
  }
}
