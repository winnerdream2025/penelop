// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wallet _$WalletFromJson(Map<String, dynamic> json) => Wallet(
  balance: (json['balance'] as num).toDouble(),
  userId: json['userId'] as String,
  accountNumber: json['accountNumber'] as String,
);

Map<String, dynamic> _$WalletToJson(Wallet instance) => <String, dynamic>{
  'balance': instance.balance,
  'accountNumber': instance.accountNumber,
  'userId': instance.userId,
};
