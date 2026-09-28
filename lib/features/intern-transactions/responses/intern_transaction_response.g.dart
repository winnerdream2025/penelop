// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intern_transaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InternTransactionResponse _$InternTransactionResponseFromJson(
  Map<String, dynamic> json,
) => InternTransactionResponse(
  data: json['data'] == null
      ? null
      : InternTransaction.fromJson(json['data'] as Map<String, dynamic>),
  message: json['message'] as String,
  status: json['status'] as bool,
);

Map<String, dynamic> _$InternTransactionResponseToJson(
  InternTransactionResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'status': instance.status,
  'data': instance.data,
};
