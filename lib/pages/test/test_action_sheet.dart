import 'package:flutter/material.dart';
import 'package:lingo_dragon/common/widgets/action_sheet.dart';
import 'package:lingo_dragon/common/widgets/scaffold.dart';

class TestActionSheet extends StatefulWidget {
  const TestActionSheet({Key? key}) : super(key: key);

  @override
  State<TestActionSheet> createState() => _TestActionSheetState();
}

class _TestActionSheetState extends State<TestActionSheet> {
  @override
  Widget build(BuildContext context) {
    return SPScaffold(
        title: const Text("Test Action Sheet"),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,

          children: [
            ElevatedButton(
                onPressed: () async {
                  await SPActionSheet.showActionSheet(
                      context, {4: "Item 4", 1: "Item 1", 2: "Item 2"},
                      title: "Select Your Option",
                      showCancelButton: true);
                },
                child: const Text("Open action sheet")),
          ],
        ));
  }
}
