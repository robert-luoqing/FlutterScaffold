import '../../common/widgets/scaffold.dart';

import '../../common/widgets/toast.dart';
import 'package:flutter/material.dart';

class ToastTestView extends StatefulWidget {
  const ToastTestView({Key? key}) : super(key: key);

  @override
  _ToastTestViewState createState() => _ToastTestViewState();
}

class _ToastTestViewState extends State<ToastTestView> {
  @override
  Widget build(BuildContext context) {
    return SPScaffold(
        title: const Text("Test"),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,

          children: [
            ElevatedButton(
              onPressed: () {
                SPToast.show(context, "Test toast");
              },
              child: const Text("Click"),
            )
          ],
        ));
  }
}
