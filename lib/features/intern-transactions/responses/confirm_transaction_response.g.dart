// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_transaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmTransactionResponse _$ConfirmTransactionResponseFromJson(
  Map<String, dynamic> json,
) => ConfirmTransactionResponse(
  message: json['message'] as String,
  status: json['status'] as bool,
  data: json['data'] == null
      ? null
      : DashboardData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ConfirmTransactionResponseToJson(
  ConfirmTransactionResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};
