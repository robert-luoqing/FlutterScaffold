import 'package:json_annotation/json_annotation.dart';

part 'login_device_info.g.dart';

@JsonSerializable()
class LoginDeviceInfo {
  String? deviceId;
  String? macAddress;
  String? platform;
  String? version;
  String? os;
  String? model;
  String? brand;
  String? maxVersion;

  LoginDeviceInfo({
    this.deviceId,
    this.macAddress,
    this.platform,
    this.version,
    this.os,
    this.model,
    this.brand,
    this.maxVersion,
  });

  factory LoginDeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$LoginDeviceInfoFromJson(json);
  Map<String, dynamic> toJson() => _$LoginDeviceInfoToJson(this);
}
