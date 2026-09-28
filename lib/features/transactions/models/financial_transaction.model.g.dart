// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_transaction.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinancialTransaction _$FinancialTransactionFromJson(
  Map<String, dynamic> json,
) => FinancialTransaction(
  reference: json['reference'] as String,
  type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
  amount: (json['amount'] as num).toDouble(),
  netAmount: (json['netAmount'] as num).toDouble(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  status: json['status'] as String,
  name: json['name'] as String,
  isSender: json['isSender'] as bool? ?? false,
);

Map<String, dynamic> _$FinancialTransactionToJson(
  FinancialTransaction instance,
) => <String, dynamic>{
  'reference': instance.reference,
  'type': _$TransactionTypeEnumMap[instance.type]!,
  'amount': instance.amount,
  'netAmount': instance.netAmount,
  'createdAt': instance.createdAt.toIso8601String(),
  'status': instance.status,
  'name': instance.name,
  'isSender': instance.isSender,
};

const _$TransactionTypeEnumMap = {
  TransactionType.DEPOSIT: 'DEPOSIT',
  TransactionType.WITHDRAWAL: 'WITHDRAWAL',
  TransactionType.TRANSFER: 'TRANSFER',
  TransactionType.FEE: 'FEE',
  TransactionType.ADJUSTMENT: 'ADJUSTMENT',
};

const _$TransactionProviderEnumMap = {
  TransactionProvider.INTERNAL: 'INTERNAL',
  TransactionProvider.PAYPAL: 'PAYPAL',
  TransactionProvider.MOBILE_MONEY: 'MOBILE_MONEY',
  TransactionProvider.CARD: 'CARD',
};

const _$TransactionStatusEnumMap = {
  TransactionStatus.PENDING: 'PENDING',
  TransactionStatus.CONFIRM: 'CONFIRM',
  TransactionStatus.SUCCESS: 'SUCCESS',
  TransactionStatus.FAILED: 'FAILED',
  TransactionStatus.CANCELED: 'CANCELED',
};
