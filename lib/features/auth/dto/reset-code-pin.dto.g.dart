// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset-code-pin.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetCodePinDto _$ResetCodePinDtoFromJson(Map<String, dynamic> json) =>
    ResetCodePinDto(
      phoneNumber: json['phoneNumber'] as String,
      newCodePin: json['newCodePin'] as String,
    );

Map<String, dynamic> _$ResetCodePinDtoToJson(ResetCodePinDto instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'newCodePin': instance.newCodePin,
    };
