import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

typedef DidFullScreenSwitchCallback = void Function(bool isFull);
typedef DidLoadVideo = void Function(String? vid, String? title);

class VideoViewController {
  final MethodChannel _channel;
  final DidFullScreenSwitchCallback? onFullScreenSwitch;
  final DidLoadVideo? onLoadVideo;

  VideoViewController(int id, this.onFullScreenSwitch, this.onLoadVideo)
      : _channel = MethodChannel('SPVideoView/$id') {
    _channel.setMethodCallHandler(_handleMethod);
  }
  Future<dynamic> _handleMethod(MethodCall call) async {
    // channel.invokeMethod("didFullScreenSwitchWrap", arguments: fullscren)
    // channel.invokeMethod("didLoadVideo", arguments: [vid: vid, title: title])

    switch (call.method) {
      case 'didFullScreenSwitchWrap':
        if (onFullScreenSwitch != null) {
          onFullScreenSwitch!(call.arguments);
        }
        return Future.value("true");
      case 'didLoadVideo':
        if (onLoadVideo != null) {
          Map<String, String> data = call.arguments;
          onLoadVideo!(data['vid'], data['title']);
        }
        return Future.value("true");
    }
  }

  Future<void> receiveFromFlutter(String text) async {
    try {
      final String result =
          await _channel.invokeMethod('receiveFromFlutter', {"text": text});
      if (kDebugMode) {
        print("Result from native: $result");
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Error from native: $e.message");
      }
    }
  }
}
