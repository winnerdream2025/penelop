import 'package:json_annotation/json_annotation.dart';
part 'reset_password_email.dto.g.dart';

@JsonSerializable()
class ResetPasswordEmailDto {
  final String email;
  final String newPassword;

  ResetPasswordEmailDto({required this.email, required this.newPassword});

  factory ResetPasswordEmailDto.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordEmailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordEmailDtoToJson(this);
}