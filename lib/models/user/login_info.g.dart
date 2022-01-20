// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginInfo _$LoginInfoFromJson(Map<String, dynamic> json) => LoginInfo(
      uid: json['uid'] as int,
      email: json['email'] as String?,
      mobile: json['mobile'] as String?,
      username: json['username'] as String?,
      avatar: json['avatar'] as String?,
      token: json['token'] as String,
      expiredTime: json['expiredTime'] as int,
      needRefreshTokenTime: json['needRefreshTokenTime'] as int,
    );

Map<String, dynamic> _$LoginInfoToJson(LoginInfo instance) => <String, dynamic>{
      'uid': instance.uid,
      'token': instance.token,
      'expiredTime': instance.expiredTime,
      'needRefreshTokenTime': instance.needRefreshTokenTime,
      'email': instance.email,
      'mobile': instance.mobile,
      'username': instance.username,
      'avatar': instance.avatar,
    };
