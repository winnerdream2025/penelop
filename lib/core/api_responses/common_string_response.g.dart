// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_string_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonStringResponse _$CommonStringResponseFromJson(
  Map<String, dynamic> json,
) => CommonStringResponse(
  message: json['message'] as String,
  status: json['status'] as bool,
  data: json['data'] as String?,
);

Map<String, dynamic> _$CommonStringResponseToJson(
  CommonStringResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};
