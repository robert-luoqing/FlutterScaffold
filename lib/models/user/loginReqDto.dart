import 'package:json_annotation/json_annotation.dart';

part 'loginReqDto.g.dart';

@JsonSerializable()
class LoginReqDto {
  String countryCode;
  String mobileNumber;
  String password;
  String deviceId;
  String macAddress;
  String platform;
  String version;
  String os;
  String model;
  String brand;
  String maxVersion;
  String ip;

  LoginReqDto({
    required this.countryCode,
    required this.mobileNumber,
    required this.password,
    required this.deviceId,
    required this.macAddress,
    required this.platform,
    required this.version,
    required this.os,
    required this.model,
    required this.brand,
    required this.maxVersion,
    required this.ip,
  });

  factory LoginReqDto.fromJson(Map<String, dynamic> json) =>
      _$LoginReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$LoginReqDtoToJson(this);
}
