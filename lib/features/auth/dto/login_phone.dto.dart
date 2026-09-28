import 'package:json_annotation/json_annotation.dart';

part 'login_phone.dto.g.dart';

@JsonSerializable()
class LoginPhoneDto {
  final String phoneNumber;
  final String password;
  final String fcmToken;

  LoginPhoneDto({
    required this.phoneNumber,
    required this.password,
    required this.fcmToken,
  });

  factory LoginPhoneDto.fromJson(Map<String, dynamic> json) =>
      _$LoginPhoneDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginPhoneDtoToJson(this);
}
