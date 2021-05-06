import '../../common/controlls/dialog.dart';
import 'package:flutter/material.dart';

class TestDialogView extends StatefulWidget {
  @override
  _TestDialogViewState createState() => _TestDialogViewState();
}

class _TestDialogViewState extends State<TestDialogView> {
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
                    await SPDialog.alert(context, "I'm robert", title: "Hello");
                    SPDialog.alert(context, "Done");
                  },
                  child: Text("Open Alert")),
              ElevatedButton(
                  onPressed: () async {
                    var result = await SPDialog.confirm(
                        context, "Are you Sharon?",
                        title: "Ask question");
                    if (result) {
                      SPDialog.alert(context, "I'm Sharon");
                    } else {
                      SPDialog.alert(context, "I'm not Sharon");
                    }
                  },
                  child: Text("Open Confirm")),
            ],
          ),
        ));
  }
}
