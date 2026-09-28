// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_intern_transaction.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateInternTransactionDto _$CreateInternTransactionDtoFromJson(
  Map<String, dynamic> json,
) => CreateInternTransactionDto(
  amount: (json['amount'] as num).toDouble(),
  to: json['to'] as String,
);

Map<String, dynamic> _$CreateInternTransactionDtoToJson(
  CreateInternTransactionDto instance,
) => <String, dynamic>{'amount': instance.amount, 'to': instance.to};
