import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_resp_dto.g.dart';

@JsonSerializable()
class RefreshTokenResp {
  String token;
  int expiredTime;

  RefreshTokenResp({required this.token, required this.expiredTime});
  factory RefreshTokenResp.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRespFromJson(json);
  Map<String, dynamic> toJson() => _$RefreshTokenRespToJson(this);
}
