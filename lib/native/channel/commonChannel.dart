import 'package:flutter/services.dart';

class CommonChannel {
  static const platform = const MethodChannel('SPCommonChannel');
  static bool initialized = false;
  static void initChannel() {
    if (initialized == false) {
      platform.setMethodCallHandler(_handleMethod);
      initialized = true;
    }
  }

  Future<int> test() async {
    final int result = await platform.invokeMethod('test');
    return result;
  }

  static Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case 'sendFromNative':
        String text = call.arguments as String;
        return new Future.value("Text from native: $text");
    }
  }
}
