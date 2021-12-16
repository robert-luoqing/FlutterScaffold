import '../../common/controlls/modalSideSheet.dart';
import '../../common/controlls/scaffold.dart';
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
                leading: Icon(Icons.face),
                title: Text("I am on $index index"),
                trailing: Icon(Icons.safety_divider),
              );
            },
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SPScaffold(
      title: Text("Sidebar test"),
      body: Container(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  _openSidebar(ModalSideSheetType.left);
                },
                child: Text("Open left sidebar")),
            ElevatedButton(
                onPressed: () {
                  _openSidebar(ModalSideSheetType.right);
                },
                child: Text("Open right sidebar"))
          ],
        ),
      ),
    );
  }
}
