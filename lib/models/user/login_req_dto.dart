import 'package:json_annotation/json_annotation.dart';
import 'package:lingo_dragon/models/user/login_device_info.dart';

part 'login_req_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginReqDto {
  int loginType;
  String? countryCode;
  String? mobileNumber;
  String? email;
  String? validateCode;
  String? thirdToken;
  String? authPlatform;
  LoginDeviceInfo deviceInfo;

  LoginReqDto({
    required this.loginType,
    this.countryCode,
    this.mobileNumber,
    this.email,
    this.validateCode,
    this.thirdToken,
    this.authPlatform,
    required this.deviceInfo,
  });

  factory LoginReqDto.fromJson(Map<String, dynamic> json) =>
      _$LoginReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$LoginReqDtoToJson(this);
}
