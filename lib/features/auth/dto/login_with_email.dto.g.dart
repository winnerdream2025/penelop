// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_with_email.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginWithEmailDto _$LoginWithEmailDtoFromJson(Map<String, dynamic> json) =>
    LoginWithEmailDto(
      email: json['email'] as String,
      password: json['password'] as String,
      fcmToken: json['fcmToken'] as String,
    );

Map<String, dynamic> _$LoginWithEmailDtoToJson(LoginWithEmailDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'fcmToken': instance.fcmToken,
    };
