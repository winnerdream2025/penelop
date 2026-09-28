// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_phone.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginPhoneDto _$LoginPhoneDtoFromJson(Map<String, dynamic> json) =>
    LoginPhoneDto(
      phoneNumber: json['phoneNumber'] as String,
      password: json['password'] as String,
      fcmToken: json['fcmToken'] as String,
    );

Map<String, dynamic> _$LoginPhoneDtoToJson(LoginPhoneDto instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'fcmToken': instance.fcmToken,
    };
