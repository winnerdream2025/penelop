// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterDto _$RegisterDtoFromJson(Map<String, dynamic> json) => RegisterDto(
  password: json['password'] as String?,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  country: json['country'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  fcmToken: json['fcmToken'] as String?,
);

Map<String, dynamic> _$RegisterDtoToJson(RegisterDto instance) =>
    <String, dynamic>{
      'password': instance.password,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'country': instance.country,
      'phoneNumber': instance.phoneNumber,
      'fcmToken': instance.fcmToken,
    };
