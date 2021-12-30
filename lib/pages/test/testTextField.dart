import 'package:FlutterScaffold/common/controlls/button.dart';
import 'package:FlutterScaffold/common/controlls/scaffold.dart';
import '../../common/controlls/chat-list/scrollable_positioned_list.dart';

import '../../common/controlls/textField.dart';
import 'package:flutter/material.dart';

class TestTextField extends StatefulWidget {
  @override
  _TestTextFieldState createState() => _TestTextFieldState();
}

class _TestTextFieldState extends State<TestTextField> {
  List<String> chatListContents = [];
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SPScaffold(
        title: Text("Text field"),
        resizeToAvoidBottomInset: true,
        body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,

                children: [
                  // Text field in ListTile can't input space
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
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('Career'),
                      ),
                      Expanded(
                          child: TextField(
                              // textAlign: TextAlign.end,
                              decoration: InputDecoration.collapsed(
                                  hintText: 'Input your career'))),
                    ],
                  ),
                  Expanded(flex: 1, child: Container()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(children: [
                      Expanded(
                        child: SPTextField(
                          controller: myController,
                        ),
                      ),
                      SPButton(
                          pattern: SPButtonPattern.primaryRoundButton,
                          fitContent: true,
                          onPressed: () {
                            if (myController.text.isNotEmpty) {
                              setState(() {
                                chatListContents.insert(
                                    0, myController.text.trim());
                              });
                              myController.text = "";
                            }
                          },
                          text: "Send")
                    ]),
                  )
                ],
              ),
            )));
  }

  @override
  void initState() {
    super.initState();
    myController.text = "hello";
    // Start listening to changes.
    myController.addListener(_printLatestValue);
  }

  _printLatestValue() {
    // print("Second text field: ${myController.text}");
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }
}
