// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant-account-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantAccountModel _$MerchantAccountModelFromJson(
  Map<String, dynamic> json,
) => MerchantAccountModel(
  balance: (json['balance'] as num).toDouble(),
  designation: json['designation'] as String,
  id: json['id'] as String,
  merchantCode: json['merchantCode'] as String,
);

Map<String, dynamic> _$MerchantAccountModelToJson(
  MerchantAccountModel instance,
) => <String, dynamic>{
  'balance': instance.balance,
  'designation': instance.designation,
  'merchantCode': instance.merchantCode,
  'id': instance.id,
};
