// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyOtpDto _$VerifyOtpDtoFromJson(Map<String, dynamic> json) => VerifyOtpDto(
  code: json['code'] as String,
  identifier: json['identifier'] as String,
);

Map<String, dynamic> _$VerifyOtpDtoToJson(VerifyOtpDto instance) =>
    <String, dynamic>{'code': instance.code, 'identifier': instance.identifier};
