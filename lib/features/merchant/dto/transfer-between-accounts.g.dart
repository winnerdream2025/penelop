// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer-between-accounts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferBetweenAccountsDto _$TransferBetweenAccountsDtoFromJson(
  Map<String, dynamic> json,
) => TransferBetweenAccountsDto(
  direction: $enumDecode(_$TransferDirectionEnumMap, json['direction']),
  amount: (json['amount'] as num).toDouble(),
);

Map<String, dynamic> _$TransferBetweenAccountsDtoToJson(
  TransferBetweenAccountsDto instance,
) => <String, dynamic>{
  'direction': _$TransferDirectionEnumMap[instance.direction]!,
  'amount': instance.amount,
};

const _$TransferDirectionEnumMap = {
  TransferDirection.personalToMerchant: 'PERSONAL_TO_MERCHANT',
  TransferDirection.merchantToPersonal: 'MERCHANT_TO_PERSONAL',
};
