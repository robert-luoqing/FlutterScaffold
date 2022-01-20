// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token_resp_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshTokenResp _$RefreshTokenRespFromJson(Map<String, dynamic> json) =>
    RefreshTokenResp(
      token: json['token'] as String,
      expiredTime: json['expiredTime'] as int,
    );

Map<String, dynamic> _$RefreshTokenRespToJson(RefreshTokenResp instance) =>
    <String, dynamic>{
      'token': instance.token,
      'expiredTime': instance.expiredTime,
    };
