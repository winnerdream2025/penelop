// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_pin.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetPinDto _$SetPinDtoFromJson(Map<String, dynamic> json) => SetPinDto(
  curentCodePin: json['curentCodePin'] as String,
  newCodePin: json['newCodePin'] as String,
);

Map<String, dynamic> _$SetPinDtoToJson(SetPinDto instance) => <String, dynamic>{
  'newCodePin': instance.newCodePin,
  'curentCodePin': instance.curentCodePin,
};
