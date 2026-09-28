import 'package:json_annotation/json_annotation.dart';
part 'reset_password_dto.g.dart';

@JsonSerializable()
class ResetPasswordDto {
  final String phoneNumber;
  final String newPassword;

  ResetPasswordDto({required this.phoneNumber, required this.newPassword});

  factory ResetPasswordDto.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordDtoToJson(this);
}