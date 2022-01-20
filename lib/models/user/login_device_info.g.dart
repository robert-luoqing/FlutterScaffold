// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_device_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginDeviceInfo _$LoginDeviceInfoFromJson(Map<String, dynamic> json) =>
    LoginDeviceInfo(
      deviceId: json['deviceId'] as String?,
      macAddress: json['macAddress'] as String?,
      platform: json['platform'] as String?,
      version: json['version'] as String?,
      os: json['os'] as String?,
      model: json['model'] as String?,
      brand: json['brand'] as String?,
      maxVersion: json['maxVersion'] as String?,
    );

Map<String, dynamic> _$LoginDeviceInfoToJson(LoginDeviceInfo instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'macAddress': instance.macAddress,
      'platform': instance.platform,
      'version': instance.version,
      'os': instance.os,
      'model': instance.model,
      'brand': instance.brand,
      'maxVersion': instance.maxVersion,
    };
