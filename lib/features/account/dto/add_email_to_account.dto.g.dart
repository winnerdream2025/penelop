// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_email_to_account.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddEmailToAccountDto _$AddEmailToAccountDtoFromJson(
  Map<String, dynamic> json,
) => AddEmailToAccountDto(
  email: json['email'] as String,
  otp: json['otp'] as String,
);

Map<String, dynamic> _$AddEmailToAccountDtoToJson(
  AddEmailToAccountDto instance,
) => <String, dynamic>{'email': instance.email, 'otp': instance.otp};
