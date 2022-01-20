import '../../common/controlls/webview.dart';
import 'package:flutter/material.dart';

class MyWebView extends StatefulWidget {
  const MyWebView({Key? key}) : super(key: key);

  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String _title = "Webview Sample";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text(_title)),
      body: const SPWebview(
        url: 'https://www.baidu.com',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _sendToWebview("Hello how are you", null);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
