import '../../common/controlls/dialog.dart';
import '../../common/controlls/textField.dart';
import 'package:flutter/material.dart';

class TestTextField extends StatefulWidget {
  @override
  _TestTextFieldState createState() => _TestTextFieldState();
}

class _TestTextFieldState extends State<TestTextField> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Text field")),
        body: Container(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,

            children: [
              SPTextField(
                controller: myController,
              ),
              ElevatedButton(
                  onPressed: () async {
                    SPDialog.alert(context, "${myController.text}");
                  },
                  child: Text("Test")),
              ListTile(
                title: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text('Career'),
                    ),
                    Expanded(
                        child: TextField(
                            // textAlign: TextAlign.end,
                            decoration: InputDecoration.collapsed(
                                hintText: 'Input your career'))),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    myController.text = "hello";
    // Start listening to changes.
    myController.addListener(_printLatestValue);
  }

  _printLatestValue() {
    print("Second text field: ${myController.text}");
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }
}
