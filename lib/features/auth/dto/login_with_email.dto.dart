import 'package:json_annotation/json_annotation.dart';

part 'login_with_email.dto.g.dart';

@JsonSerializable()
class LoginWithEmailDto{
  final String email;
  final String password;
  final String fcmToken;

  LoginWithEmailDto({
    required this.email,
    required this.password,
    required this.fcmToken,
  });

  factory LoginWithEmailDto.fromJson(Map<String, dynamic> json) =>
      _$LoginWithEmailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginWithEmailDtoToJson(this);
}
