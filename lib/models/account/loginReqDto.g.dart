// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loginReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginReqDto _$LoginReqDtoFromJson(Map<String, dynamic> json) {
  return LoginReqDto(
    type: json['type'] as int,
    osName: json['osname'] as String,
    userAgent: json['user_agent'] as String,
    account: json['account'] as String?,
    password: json['password'] as String?,
    mobile: json['mobile'] as String?,
    yzm: json['yzm'] as String?,
  );
}

Map<String, dynamic> _$LoginReqDtoToJson(LoginReqDto instance) =>
    <String, dynamic>{
      'type': instance.type,
      'account': instance.account,
      'password': instance.password,
      'mobile': instance.mobile,
      'yzm': instance.yzm,
      'osname': instance.osName,
      'user_agent': instance.userAgent,
    };
