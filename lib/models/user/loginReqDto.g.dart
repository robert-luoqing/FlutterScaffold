// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loginReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginReqDto _$LoginReqDtoFromJson(Map<String, dynamic> json) => LoginReqDto(
      countryCode: json['countryCode'] as String,
      mobileNumber: json['mobileNumber'] as String,
      password: json['password'] as String,
      deviceId: json['deviceId'] as String,
      macAddress: json['macAddress'] as String,
      platform: json['platform'] as String,
      version: json['version'] as String,
      os: json['os'] as String,
      model: json['model'] as String,
      brand: json['brand'] as String,
      maxVersion: json['maxVersion'] as String,
      ip: json['ip'] as String,
    );

Map<String, dynamic> _$LoginReqDtoToJson(LoginReqDto instance) =>
    <String, dynamic>{
      'countryCode': instance.countryCode,
      'mobileNumber': instance.mobileNumber,
      'password': instance.password,
      'deviceId': instance.deviceId,
      'macAddress': instance.macAddress,
      'platform': instance.platform,
      'version': instance.version,
      'os': instance.os,
      'model': instance.model,
      'brand': instance.brand,
      'maxVersion': instance.maxVersion,
      'ip': instance.ip,
    };
