// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_resp_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRespDto _$LoginRespDtoFromJson(Map<String, dynamic> json) => LoginRespDto(
      uid: json['uid'] as int,
      email: json['email'] as String?,
      mobile: json['mobile'] as String?,
      username: json['username'] as String?,
      avatar: json['avatar'] as String?,
      token: json['token'] as String,
      expiredTime: json['expiredTime'] as int,
    );

Map<String, dynamic> _$LoginRespDtoToJson(LoginRespDto instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'mobile': instance.mobile,
      'username': instance.username,
      'avatar': instance.avatar,
      'token': instance.token,
      'expiredTime': instance.expiredTime,
    };
