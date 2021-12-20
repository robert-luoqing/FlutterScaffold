import 'package:json_annotation/json_annotation.dart';

part 'loginRespDto.g.dart';

@JsonSerializable()
class LoginRespDto {
  String id;
  String token;

  LoginRespDto({
    required this.id,
    required this.token,
  });

  factory LoginRespDto.fromJson(Map<String, dynamic> json) =>
      _$LoginRespDtoFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRespDtoToJson(this);
}
