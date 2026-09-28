// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm-request.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmRequestDto _$ConfirmRequestDtoFromJson(Map<String, dynamic> json) =>
    ConfirmRequestDto(
      pin: json['pin'] as String,
      requestId: json['requestId'] as String,
    );

Map<String, dynamic> _$ConfirmRequestDtoToJson(ConfirmRequestDto instance) =>
    <String, dynamic>{'pin': instance.pin, 'requestId': instance.requestId};
