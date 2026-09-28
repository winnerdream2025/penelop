// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_money_to_wallet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddMoneyToWalletModel _$AddMoneyToWalletModelFromJson(
  Map<String, dynamic> json,
) => AddMoneyToWalletModel(
  reference: json['reference'] as String,
  amount: (json['amount'] as num).toDouble(),
  status: json['status'] as String,
  phone: json['phone'] as String,
  provider: json['provider'] as String,
  providerFee: (json['providerFee'] as num).toDouble(),
  corisFee: (json['corisFee'] as num).toDouble(),
  account: json['account'] as String,
);

Map<String, dynamic> _$AddMoneyToWalletModelToJson(
  AddMoneyToWalletModel instance,
) => <String, dynamic>{
  'reference': instance.reference,
  'amount': instance.amount,
  'status': instance.status,
  'phone': instance.phone,
  'provider': instance.provider,
  'providerFee': instance.providerFee,
  'corisFee': instance.corisFee,
  'account': instance.account,
};
