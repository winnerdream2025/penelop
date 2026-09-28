// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobile_recharge_preview_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MobileRechargePreviewData _$MobileRechargePreviewDataFromJson(
  Map<String, dynamic> json,
) => MobileRechargePreviewData(
  amount: (json['amount'] as num).toDouble(),
  netAmount: (json['netAmount'] as num).toDouble(),
  providerFee: (json['providerFee'] as num).toDouble(),
  corisFee: (json['corisFee'] as num).toDouble(),
  totalFee: (json['totalFee'] as num).toDouble(),
  operator: json['operator'] as String,
  phoneNumber: json['phoneNumber'] as String,
  country: json['country'] as String,
);

Map<String, dynamic> _$MobileRechargePreviewDataToJson(
  MobileRechargePreviewData instance,
) => <String, dynamic>{
  'amount': instance.amount,
  'netAmount': instance.netAmount,
  'providerFee': instance.providerFee,
  'corisFee': instance.corisFee,
  'totalFee': instance.totalFee,
  'operator': instance.operator,
  'phoneNumber': instance.phoneNumber,
  'country': instance.country,
};
