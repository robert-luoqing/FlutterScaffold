import '../../common/widgets/qr_scanner.dart';
import 'package:flutter/material.dart';

class TestQrScanView extends StatefulWidget {
  const TestQrScanView({Key? key}) : super(key: key);

  @override
  _TestQrScanViewState createState() => _TestQrScanViewState();
}

class _TestQrScanViewState extends State<TestQrScanView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Test")),
      body: SPQRScanner(
        onScanFinished: (String qr) {},
      ),
    );
  }
}
