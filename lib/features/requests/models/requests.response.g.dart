// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requests.response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestsResponse _$RequestsResponseFromJson(Map<String, dynamic> json) =>
    RequestsResponse(
      message: json['message'] as String,
      status: json['status'] as bool,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => UserRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RequestsResponseToJson(RequestsResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'data': instance.data,
    };
