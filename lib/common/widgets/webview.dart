import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../utils/encrypt_util.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

typedef SPWebviewTitleChanged = void Function(String? title);
typedef SPWebviewCallback = void Function(String type, dynamic data);

class SPWebview extends StatefulWidget {
  final SPWebviewTitleChanged? onTitleChanged;
  final SPWebviewCallback? onCallback;
  final String url;
  const SPWebview(
      {required this.url, this.onTitleChanged, this.onCallback, Key? key})
      : super(key: key);

  @override
  SPWebviewState createState() => SPWebviewState();
}

class SPWebviewState extends State<SPWebview>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  WebViewController? _controller;
  late AnimationController _loadController;
  bool _showLoading = false;
  String? _title = "";

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    if (kDebugMode) {
      print("========================>view loaded ${widget.url}");
    }
    _loadController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    super.initState();
  }

  Future<void> _fetchTitle() async {
    try {
      if (_controller != null) {
        var newTitle = await _controller!.getTitle();
        if (_title != newTitle) {
          _title = newTitle;
          if (widget.onTitleChanged != null) {
            widget.onTitleChanged!(_title);
          }
        }
      }
    } catch (e, _) {
      // do nothing
    }
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
                    valueColor: const AlwaysStoppedAnimation(Colors.green),
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
    super.build(context);
    return Stack(children: [
      Positioned(
        left: 0,
        right: 0,
        top: 0,
        bottom: 0,
        child: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          userAgent:
              "user-agent: Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Mobile Safari/537.36",
          javascriptChannels: {
            JavascriptChannel(
                name: 'messageHandler',
                onMessageReceived: (JavascriptMessage message) {
                  var msg = message.message;
                  var decodeBase64 = EncryptUtil.decodeBase64(msg);
                  var decodeUrlComponent =
                      EncryptUtil.decodeComponent(decodeBase64);
                  Map<String, dynamic> jsonObj = jsonDecode(decodeUrlComponent);
                  var type = jsonObj["type"] as String;
                  var data = jsonObj["data"];
                  if (widget.onCallback != null) {
                    widget.onCallback!(type, data);
                  }
                })
          },
          onWebViewCreated: (WebViewController webViewController) {
            _controller = webViewController;
            _loadHtmlFromAssetsOrUrl();
            _fetchTitle();
          },
          onProgress: (int progress) {
            if (kDebugMode) {
              print("load url progress: $progress");
            }
            var newProgress = progress / 100.0;
            if (newProgress < 0 / 1) {
              newProgress = 0.1;
            }
            _loadController.value = newProgress;
            _fetchTitle();
          },
          onPageFinished: (String url) async {
            if (kDebugMode) {
              print("load url finished: $url");
            }
            _fetchTitle();
            _loadController.value = 1;
            await Future.delayed(const Duration(milliseconds: 200));
            if (_loadController.value == 1) {
              setState(() {
                _showLoading = false;
              });
            }
          },
          onPageStarted: (String url) {
            var lowerUrl = url.toLowerCase().trim();
            if (lowerUrl.startsWith("http://") ||
                lowerUrl.startsWith("https://")) {
              if (kDebugMode) {
                print("load url started: $url");
              }
              _loadController.value = 0.1;
              setState(() {
                _showLoading = true;
              });
              _fetchTitle();
            }
          },
          onWebResourceError: (WebResourceError error) {},
          navigationDelegate: (NavigationRequest request) {
            if (kDebugMode) {
              print("url: ${request.url}");
            }
            var lowerUrl = request.url.toLowerCase().trim();
            if (lowerUrl.startsWith("http://") ||
                lowerUrl.startsWith("https://") ||
                lowerUrl.startsWith("ftp://") ||
                lowerUrl.startsWith("ws://") ||
                lowerUrl.startsWith("wss://")) {
              return NavigationDecision.navigate;
            } else {
              launch(request.url);
              return NavigationDecision.prevent;
            }
          },
        ),
      ),
      _buildProgress(),
    ]);
  }

  _loadHtmlFromAssetsOrUrl() async {
    // String fileText = await rootBundle.loadString('assets/index.html');
    // _controller?.loadUrl(Uri.dataFromString(fileText,
    //         mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
    //     .toString());
    // this._controller!.loadUrl(widget.url);
  }

  /// @data is json object
  sendToWebview(String type, dynamic data) {
    String encodeBase64 = "";
    if (data != null) {
      String jsonStr = jsonEncode(data);
      encodeBase64 =
          EncryptUtil.encodeBase64(EncryptUtil.encodeComponent(jsonStr));
    }

    _controller?.runJavascript('fromFlutter("$type", "$encodeBase64")');
  }

  @override
  void dispose() {
    _loadController.dispose();
    super.dispose();
    if (kDebugMode) {
      print('webview disposed');
    }
  }
}
