// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deletion_status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeletionStatusResponse _$DeletionStatusResponseFromJson(
  Map<String, dynamic> json,
) => DeletionStatusResponse(
  status: json['status'] as bool,
  message: json['message'] as String,
  deletionRequestedAt: json['deletionRequestedAt'] as String?,
  deletionScheduledFor: json['deletionScheduledFor'] as String?,
);

Map<String, dynamic> _$DeletionStatusResponseToJson(
  DeletionStatusResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'deletionRequestedAt': instance.deletionRequestedAt,
  'deletionScheduledFor': instance.deletionScheduledFor,
};
