import 'package:lingo_dragon/common/widgets/scaffold.dart';

import '../../common/widgets/dialog.dart';
import 'package:flutter/material.dart';

class TestDialogView extends StatefulWidget {
  const TestDialogView({Key? key}) : super(key: key);

  @override
  _TestDialogViewState createState() => _TestDialogViewState();
}

class _TestDialogViewState extends State<TestDialogView> {
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
                  await SPDialog.alert(context, "I'm robert", title: "Hello");
                  // SPDialog.alert(context, "Done");
                },
                child: const Text("Open Alert")),
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
                child: const Text("Open Confirm")),
            ElevatedButton(
                onPressed: () async {
                  var result = await SPDialog.showInputDialog(
                      context: this.context, title: "Please input some text");
                  SPDialog.alert(context, "input: $result");
                },
                child: const Text("Open Prompt")),
            ElevatedButton(
                onPressed: () async {
                  SPDialog.showBottomDialog(
                    context: context,
                    backgroundColor: Colors.black,
                    widget: const Padding(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: TextField(
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 8),
                            border: InputBorder.none,
                          )),
                    ),
                  );
                },
                child: const Text("Open Bottom Prompt")),
          ],
        ));
  }
}
