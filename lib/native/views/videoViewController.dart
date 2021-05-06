import 'package:flutter/services.dart';

typedef void DidFullScreenSwitchCallback(bool isFull);
typedef void DidLoadVideo(String? vid, String? title);

class VideoViewController {
  MethodChannel _channel;
  final DidFullScreenSwitchCallback? onFullScreenSwitch;
  final DidLoadVideo? onLoadVideo;

  VideoViewController(int id, this.onFullScreenSwitch, this.onLoadVideo)
      : _channel = new MethodChannel('SPVideoView/$id') {
    _channel.setMethodCallHandler(_handleMethod);
  }
  Future<dynamic> _handleMethod(MethodCall call) async {
    // channel.invokeMethod("didFullScreenSwitchWrap", arguments: fullscren)
    // channel.invokeMethod("didLoadVideo", arguments: [vid: vid, title: title])

    switch (call.method) {
      case 'didFullScreenSwitchWrap':
        if (this.onFullScreenSwitch != null) {
          this.onFullScreenSwitch!(call.arguments);
        }
        return new Future.value("true");
      case 'didLoadVideo':
        if (this.onLoadVideo != null) {
          Map<String, String> data = call.arguments;
          this.onLoadVideo!(data['vid'], data['title']);
        }
        return new Future.value("true");
    }
  }

  Future<void> receiveFromFlutter(String text) async {
    try {
      final String result =
          await _channel.invokeMethod('receiveFromFlutter', {"text": text});
      print("Result from native: $result");
    } on PlatformException catch (e) {
      print("Error from native: $e.message");
    }
  }
}
