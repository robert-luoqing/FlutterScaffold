import 'package:flutter_list_view/flutter_list_view.dart';
import 'package:lingo_dragon/common/controlls/button.dart';
import 'package:lingo_dragon/common/controlls/scaffold.dart';
import 'package:lingo_dragon/common/utils/uuid_util.dart';

import '../../common/controlls/text_field.dart';
import 'package:flutter/material.dart';

class ChatModel {
  ChatModel({required this.id, required this.msg});
  String id;
  String msg;
}

class TestChat extends StatefulWidget {
  const TestChat({Key? key}) : super(key: key);

  @override
  _TestChatState createState() => _TestChatState();
}

class _TestChatState extends State<TestChat> {
  List<ChatModel> chatListContents = [];
  final myController = TextEditingController();
  var stackKey = GlobalKey();
  var listBottom = 0.0;
  _submitMessage() {
    if (myController.text.isNotEmpty) {
      setState(() {
        chatListContents.insert(
            0,
            ChatModel(
                id: SPUUIDUtil.generateUUID(), msg: myController.text.trim()));
      });
      myController.text = "";
    }
  }

  _renderList() {
    return FlutterListView(
        reverse: true,
        physics: const BouncingScrollPhysics(),
        delegate: FlutterListViewDelegate(
            (BuildContext context, int index) => Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          chatListContents[index].msg,
                          // textAlign: TextAlign.right,
                          style: const TextStyle(
                              fontSize: 14.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
            childCount: chatListContents.length,
            onItemKey: (index) => chatListContents[index].id,
            keepPosition: true,
            keepPositionOffset: 80,
            firstItemAlign: FirstItemAlign.end));
  }

  @override
  Widget build(BuildContext context) {
    return SPScaffold(
        title: const Text("Text Chat"),
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
