// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loginRespDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRespDto _$LoginRespDtoFromJson(Map<String, dynamic> json) {
  return LoginRespDto(
    id: json['id'] as int,
    token: json['token'] as String,
    email: json['email'] as String?,
    mobile: json['mobile'] as String?,
    userName: json['userName'] as String?,
  );
}

Map<String, dynamic> _$LoginRespDtoToJson(LoginRespDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
      'email': instance.email,
      'mobile': instance.mobile,
      'userName': instance.userName,
    };
