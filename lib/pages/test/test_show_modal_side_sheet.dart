import '../../common/widgets/modal_side_sheet.dart';
import '../../common/widgets/scaffold.dart';
import 'package:flutter/material.dart';

class TestShowModalSideSheet extends StatefulWidget {
  const TestShowModalSideSheet({Key? key}) : super(key: key);

  @override
  _TestShowModalSideSheetState createState() => _TestShowModalSideSheetState();
}

class _TestShowModalSideSheetState extends State<TestShowModalSideSheet> {
  _openSidebar(ModalSideSheetType type) {
    showModalSideSheet(
        context: context,
        barrierDismissible: true,
        type: type,
        body: SafeArea(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.face),
                title: Text("I am on $index index"),
                trailing: const Icon(Icons.safety_divider),
              );
            },
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SPScaffold(
      title: const Text("Sidebar test"),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                _openSidebar(ModalSideSheetType.left);
              },
              child: const Text("Open left sidebar")),
          ElevatedButton(
              onPressed: () {
                _openSidebar(ModalSideSheetType.right);
              },
              child: const Text("Open right sidebar"))
        ],
      ),
    );
  }
}
