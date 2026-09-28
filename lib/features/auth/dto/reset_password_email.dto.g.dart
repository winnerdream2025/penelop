// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_email.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPasswordEmailDto _$ResetPasswordEmailDtoFromJson(
  Map<String, dynamic> json,
) => ResetPasswordEmailDto(
  email: json['email'] as String,
  newPassword: json['newPassword'] as String,
);

Map<String, dynamic> _$ResetPasswordEmailDtoToJson(
  ResetPasswordEmailDto instance,
) => <String, dynamic>{
  'email': instance.email,
  'newPassword': instance.newPassword,
};
