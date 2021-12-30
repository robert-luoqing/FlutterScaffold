import 'package:FlutterScaffold/common/controlls/button.dart';
import 'package:FlutterScaffold/common/controlls/scaffold.dart';
import '../../common/controlls/chat-list/scrollable_positioned_list.dart';

import '../../common/controlls/textField.dart';
import 'package:flutter/material.dart';

class TestChat extends StatefulWidget {
  @override
  _TestChatState createState() => _TestChatState();
}

class _TestChatState extends State<TestChat> {
  List<String> chatListContents = [];
  final myController = TextEditingController();
  var stackKey = GlobalKey();
  var listBottom = 0.0;
  _submitMessage() {
    if (myController.text.isNotEmpty) {
      setState(() {
        chatListContents.insert(0, myController.text.trim());
      });
      myController.text = "";
    }
  }

  _renderList() {
    return Stack(key: stackKey, children: [
      Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: listBottom,
          child: ScrollablePositionedList.builder(
            viewportLayoutUpdate:
                (viewportHeight, minScrollExtent, maxScrollExtent) {
              WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                var scrollHeight = maxScrollExtent - minScrollExtent;
                var stackHeight = stackKey.currentContext?.size?.height;
                if (stackHeight != null) {
                  if (scrollHeight < stackHeight) {
                    var temBottom = stackHeight - scrollHeight;
                    if (temBottom < 0) {
                      temBottom = 0;
                    }
                    if (temBottom != listBottom) {
                      setState(() {
                        listBottom = temBottom;
                      });
                    }
                  }
                }
              });
            },
            reverse: true,
            itemCount: chatListContents.length,
            itemBuilder: (context, index) {
              return Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        chatListContents[index],
                        // textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 14.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              );
            },
          ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SPScaffold(
        title: Text("Text Chat"),
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
                  Expanded(flex: 1, child: _renderList()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(children: [
                      Expanded(
                        child: SPTextField(
                          placeholder: "Input your message",
                          controller: myController,
                        ),
                      ),
                      SPButton(
                          pattern: SPButtonPattern.primaryRoundButton,
                          fitContent: true,
                          onPressed: () {
                            _submitMessage();
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

    // myController.text = "hello";
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
