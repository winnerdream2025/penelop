// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdrawal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawalModel _$WithdrawalModelFromJson(Map<String, dynamic> json) =>
    WithdrawalModel(
      reference: json['reference'] as String,
      amount: (json['amount'] as num).toDouble(),
      status: json['status'] as String,
      phone: json['phone'] as String,
      provider: json['provider'] as String,
      providerFee: (json['providerFee'] as num).toDouble(),
      corisFee: (json['corisFee'] as num).toDouble(),
      account: json['account'] as String,
      receiverCurrency: json['receiverCurrency'] as String,
      receiverExchangeRate: (json['receiverExchangeRate'] as num).toDouble(),
    );

Map<String, dynamic> _$WithdrawalModelToJson(WithdrawalModel instance) =>
    <String, dynamic>{
      'reference': instance.reference,
      'amount': instance.amount,
      'status': instance.status,
      'phone': instance.phone,
      'provider': instance.provider,
      'providerFee': instance.providerFee,
      'corisFee': instance.corisFee,
      'account': instance.account,
      'receiverCurrency': instance.receiverCurrency,
      'receiverExchangeRate': instance.receiverExchangeRate,
    };
