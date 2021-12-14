import '../../common/controlls/qrScanner.dart';
import 'package:flutter/material.dart';

class TestQrScanView extends StatefulWidget {
  @override
  _TestQrScanViewState createState() => _TestQrScanViewState();
}

class _TestQrScanViewState extends State<TestQrScanView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test")),
      body: Container(
          child: SPQRScanner(
        onScanFinished: (String qr) {},
      )
          // child: Column(
          //   // mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.stretch,
          //   mainAxisSize: MainAxisSize.min,

          //   children: [
          //     ElevatedButton(onPressed: () {}, child: Text("Open Scan View")),
          //   ],
          // ),
          ),
    );
  }
}
