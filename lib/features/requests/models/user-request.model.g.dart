// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user-request.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRequest _$UserRequestFromJson(Map<String, dynamic> json) => UserRequest(
  id: json['id'] as String,
  reference: json['reference'] as String,
  type: json['type'] as String,
  name: json['name'] as String,
  amount: json['amount'] as String,
  currency: json['currency'] as String,
  status: json['status'] as String,
  expiresAt: DateTime.parse(json['expiresAt'] as String),
);

Map<String, dynamic> _$UserRequestToJson(UserRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reference': instance.reference,
      'type': instance.type,
      'name': instance.name,
      'amount': instance.amount,
      'currency': instance.currency,
      'status': instance.status,
      'expiresAt': instance.expiresAt.toIso8601String(),
    };
