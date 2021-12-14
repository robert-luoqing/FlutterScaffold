import 'package:flutter/foundation.dart';
import 'package:device_info_plus/device_info_plus.dart';

class SPPlatform {
  static TargetPlatform getPlatform() {
    return defaultTargetPlatform;
  }

  static bool isIOS() {
    // 所有的都以ios风格为准
    // return true;
    return defaultTargetPlatform == TargetPlatform.iOS;
  }

  static bool isAndroid() {
    // 所有的都以ios风格为准
    // return false;
    return defaultTargetPlatform == TargetPlatform.android;
  }

  static bool isNotMobile() {
    return defaultTargetPlatform != TargetPlatform.iOS &&
        defaultTargetPlatform != TargetPlatform.android;
  }

  static Future<SPDeviceInfo?> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      var _info = SPDeviceInfo(
          osName:
              (iosInfo.name ?? "iOS") + ":" + (iosInfo.utsname.machine ?? ""),
          model: iosInfo.model ?? "");
      print("iOS info: ${_info.osName} model: ${_info.model}");
      return _info;
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      var _info = SPDeviceInfo(
          osName: "Android" +
              ":" +
              (androidInfo.version.release ??
                  androidInfo.version.baseOS ??
                  "") +
              ",Brand: " +
              (androidInfo.brand ?? "") +
              ",Manufacturer: " +
              (androidInfo.manufacturer ?? ""),
          model: androidInfo.model ?? "");
      print("Android info: ${_info.osName} model: ${_info.model}");
      return _info;
    }

    return null;
  }
}

class SPDeviceInfo {
  String osName;
  String model;
  SPDeviceInfo({required this.osName, required this.model});
}
