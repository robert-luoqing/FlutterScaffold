// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_req_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginReqDto _$LoginReqDtoFromJson(Map<String, dynamic> json) => LoginReqDto(
      loginType: json['loginType'] as int,
      countryCode: json['countryCode'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      email: json['email'] as String?,
      validateCode: json['validateCode'] as String?,
      thirdToken: json['thirdToken'] as String?,
      authPlatform: json['authPlatform'] as String?,
      deviceInfo:
          LoginDeviceInfo.fromJson(json['deviceInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginReqDtoToJson(LoginReqDto instance) =>
    <String, dynamic>{
      'loginType': instance.loginType,
      'countryCode': instance.countryCode,
      'mobileNumber': instance.mobileNumber,
      'email': instance.email,
      'validateCode': instance.validateCode,
      'thirdToken': instance.thirdToken,
      'authPlatform': instance.authPlatform,
      'deviceInfo': instance.deviceInfo.toJson(),
    };
