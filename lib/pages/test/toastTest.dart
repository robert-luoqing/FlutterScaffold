import '../../common/controlls/scaffold.dart';

import '../../common/controlls/toast.dart';
import 'package:flutter/material.dart';

class ToastTestView extends StatefulWidget {
  @override
  _ToastTestViewState createState() => _ToastTestViewState();
}

class _ToastTestViewState extends State<ToastTestView> {
  @override
  Widget build(BuildContext context) {
    return SPScaffold(
        title: Text("Test"),
        body: Container(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,

            children: [
              ElevatedButton(
                onPressed: () {
                  SPToast.show(context, "Test toast");
                },
                child: Text("Click"),
              )
            ],
          ),
        ));
  }
}
