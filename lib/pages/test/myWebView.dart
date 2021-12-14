import '../../common/controlls/webview.dart';
import 'package:flutter/material.dart';

class MyWebView extends StatefulWidget {
  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _title = "Webview Sample";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text(_title)),
      body: Container(
        child: SPWebview(
          url: 'https://www.baidu.com',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _sendToWebview("Hello how are you", null);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
