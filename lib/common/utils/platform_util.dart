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
          deviceId: iosInfo.identifierForVendor,
          platform: 'ios',
          deviceVsersion: iosInfo.systemVersion ?? "",
          os: (iosInfo.systemName ?? "iOS") +
              " - " +
              (iosInfo.systemVersion ?? ""),
          model: iosInfo.model ?? "");
      if (kDebugMode) {
        print("iOS info: ${_info.deviceId} model: ${_info.model}");
      }
      return _info;
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      var _info = SPDeviceInfo(
          deviceId: androidInfo.androidId,
          platform: 'android',
          brand: androidInfo.brand,
          deviceVsersion: androidInfo.version.release ?? "",
          os: "Android - " + (androidInfo.version.release ?? ""),
          model: androidInfo.model ?? "");
      if (kDebugMode) {
        print("Android info: ${_info.os} model: ${_info.model}");
      }
      return _info;
    }

    return null;
  }
}

class SPDeviceInfo {
  String? deviceId;
  String? macAddress;
  String? platform;
  String? version;
  String? os;
  String? model;
  String? brand;
  String? maxVersion;
  String? deviceVsersion;
  SPDeviceInfo(
      {this.deviceId,
      this.macAddress,
      this.platform,
      this.version,
      this.os,
      this.model,
      this.brand,
      this.maxVersion,
      this.deviceVsersion});
}
