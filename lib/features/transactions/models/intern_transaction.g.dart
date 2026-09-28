// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intern_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InternTransaction _$InternTransactionFromJson(Map<String, dynamic> json) =>
    InternTransaction(
      amount: (json['amount'] as num).toDouble(),
      netAmount: (json['netAmount'] as num).toDouble(),
      corisFee: (json['corisFee'] as num).toDouble(),
      recipientFirstName: json['recipientFirstName'] as String,
      recipientLastName: json['recipientLastName'] as String,
      recipientPhoneNumber: json['recipientPhoneNumber'] as String,
      amountReceived: (json['amountReceived'] as num).toDouble(),
      recipientCurrency: json['recipientCurrency'] as String,
      to: json['to'] as String,
      originalAmount: (json['originalAmount'] as num).toDouble(),
    );

Map<String, dynamic> _$InternTransactionToJson(InternTransaction instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'netAmount': instance.netAmount,
      'corisFee': instance.corisFee,
      'recipientFirstName': instance.recipientFirstName,
      'recipientLastName': instance.recipientLastName,
      'recipientPhoneNumber': instance.recipientPhoneNumber,
      'amountReceived': instance.amountReceived,
      'recipientCurrency': instance.recipientCurrency,
      'to': instance.to,
      'originalAmount': instance.originalAmount,
    };
