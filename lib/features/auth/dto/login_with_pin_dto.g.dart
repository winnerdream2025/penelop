// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_with_pin_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginWithPinDto _$LoginWithPinDtoFromJson(Map<String, dynamic> json) =>
    LoginWithPinDto(
      codePin: json['codePin'] as String?,
      biometricAuth: json['biometricAuth'] as bool,
    );

Map<String, dynamic> _$LoginWithPinDtoToJson(LoginWithPinDto instance) =>
    <String, dynamic>{
      'codePin': instance.codePin,
      'biometricAuth': instance.biometricAuth,
    };
