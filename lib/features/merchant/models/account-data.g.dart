// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account-data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
  name: json['name'] as String,
  balance: (json['balance'] as num).toDouble(),
);

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
  'name': instance.name,
  'balance': instance.balance,
};

TransferAccountsData _$TransferAccountsDataFromJson(
  Map<String, dynamic> json,
) => TransferAccountsData(
  personalAccount: Account.fromJson(
    json['personalAccount'] as Map<String, dynamic>,
  ),
  merchantAccount: json['merchantAccount'] == null
      ? null
      : Account.fromJson(json['merchantAccount'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TransferAccountsDataToJson(
  TransferAccountsData instance,
) => <String, dynamic>{
  'personalAccount': instance.personalAccount,
  'merchantAccount': instance.merchantAccount,
};
