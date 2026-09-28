// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_mobile_money_to_wallet.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddMobileMoneyToWalletDto _$AddMobileMoneyToWalletDtoFromJson(
  Map<String, dynamic> json,
) => AddMobileMoneyToWalletDto(
  amount: (json['amount'] as num).toDouble(),
  phone: json['phone'] as String,
  country: json['country'] as String,
  operator: json['operator'] as String,
);

Map<String, dynamic> _$AddMobileMoneyToWalletDtoToJson(
  AddMobileMoneyToWalletDto instance,
) => <String, dynamic>{
  'amount': instance.amount,
  'country': instance.country,
  'operator': instance.operator,
  'phone': instance.phone,
};
