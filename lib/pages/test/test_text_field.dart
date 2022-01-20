import 'package:lingo_dragon/common/controlls/button.dart';
import 'package:lingo_dragon/common/controlls/scaffold.dart';

import '../../common/controlls/text_field.dart';
import 'package:flutter/material.dart';

class TestTextField extends StatefulWidget {
  const TestTextField({Key? key}) : super(key: key);

  @override
  _TestTextFieldState createState() => _TestTextFieldState();
}

class _TestTextFieldState extends State<TestTextField> {
  List<String> chatListContents = [];
  final myController = TextEditingController();
  final firstController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SPScaffold(
        title: const Text("Text field"),
        resizeToAvoidBottomInset: true,
        body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            behavior: HitTestBehavior.opaque,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,

              children: [
                // Text field in ListTile can't input space
                ListTile(
                  title: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
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
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('Career'),
                    ),
                    Expanded(
                        child: TextField(
                            // textAlign: TextAlign.end,
                            decoration: InputDecoration.collapsed(
                                hintText: 'Input your career'))),
                  ],
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 15.0),
                      child: Text('Career'),
                    ),
                    Expanded(
                        child: SPTextField(
                      controller: firstController,
                      showClearButton: true,
                      sufixIcon: const SizedBox(
                        width: 20,
                        height: 20,
                        child: Icon(
                          Icons.access_alarm,
                          color: Colors.grey,
                          size: 17,
                        ),
                      ),
                      pattern: SPTextFieldPattern.normal,
                    )),
                  ],
                ),
                Expanded(flex: 1, child: Container()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(children: [
                    Expanded(
                      child: SPTextField(
                        controller: myController,
                        showClearButton: true,
                        pattern: SPTextFieldPattern.normal,
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
            )));
  }

  @override
  void initState() {
    super.initState();
    // myController.text = "hello";
    // Start listening to changes.
    myController.addListener(_printLatestValue);
    firstController.addListener(_printLatestValue);
  }

  _printLatestValue() {
    // print("Second text field: ${firstController.text}");
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    firstController.dispose();
    super.dispose();
  }
}
