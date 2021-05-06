import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SPWebview extends StatefulWidget {
  @override
  _SPWebviewState createState() => _SPWebviewState();
}

class _SPWebviewState extends State<SPWebview>
    with SingleTickerProviderStateMixin {
  WebViewController? _controller;
  late AnimationController _loadController;
  bool _showLoading = false;

  @override
  void initState() {
    _loadController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    super.initState();
  }

  Widget _buildProgress() {
    if (_showLoading) {
      return Positioned(
          left: 0,
          right: 0,
          top: 0,
          height: 2,
          child: SizedBox(
              height: 2,
              child: AnimatedBuilder(
                animation: _loadController,
                builder: (BuildContext context, Widget? child) {
                  return LinearProgressIndicator(
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                    value: _loadController.value,
                  );
                },
              )));
    } else {
      return Positioned(
        left: 0,
        right: 0,
        top: 0,
        height: 0,
        child: Container(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      _buildProgress(),
      Expanded(
          child: WebView(
        initialUrl: 'about:blank',
        javascriptMode: JavascriptMode.unrestricted,
        userAgent:
            "user-agent: Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Mobile Safari/537.36",
        javascriptChannels: Set.from([
          JavascriptChannel(
              name: 'messageHandler',
              onMessageReceived: (JavascriptMessage message) {
                //_title = message.message;
              })
        ]),
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;

          _loadHtmlFromAssets();
        },
        onProgress: (int progress) {
          var newProgress = progress / 100.0;
          if (newProgress < 0 / 1) {
            newProgress = 0.1;
          }
          _loadController.value = newProgress;
        },
        onPageFinished: (String url) {
          _loadController.value = 1;
        },
        onPageStarted: (String url) {
          _loadController.value = 0.1;
          setState(() {
            _showLoading = true;
          });
        },
        onWebResourceError: (WebResourceError error) {},
      ))
    ]);
  }

  _loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString('assets/index.html');
    _controller?.loadUrl(Uri.dataFromString(fileText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }

  _sendToWebview(String type, Object data) {
    // String jsonStr = jsonEncode(data);
    // String encodeBase64 = Base64Util.encode(jsonStr);
    // _controller?.evaluateJavascript('fromFlutter("$type", "$encodeBase64")');
    this._controller!.loadUrl("www.163.com");
  }

  @override
  void dispose() {
    _loadController.dispose();
    super.dispose();
  }
}
