// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobile_withdrawal_preview_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MobileWithdrawalPreviewData _$MobileWithdrawalPreviewDataFromJson(
  Map<String, dynamic> json,
) => MobileWithdrawalPreviewData(
  amount: (json['amount'] as num).toDouble(),
  netAmount: (json['netAmount'] as num).toDouble(),
  providerFee: (json['providerFee'] as num).toDouble(),
  corisFee: (json['corisFee'] as num).toDouble(),
  totalFee: (json['totalFee'] as num).toDouble(),
  operator: json['operator'] as String,
  phoneNumber: json['phoneNumber'] as String,
  country: json['country'] as String,
  amountToDebit: (json['amountToDebit'] as num).toDouble(),
);

Map<String, dynamic> _$MobileWithdrawalPreviewDataToJson(
  MobileWithdrawalPreviewData instance,
) => <String, dynamic>{
  'amount': instance.amount,
  'amountToDebit': instance.amountToDebit,
  'netAmount': instance.netAmount,
  'providerFee': instance.providerFee,
  'corisFee': instance.corisFee,
  'totalFee': instance.totalFee,
  'operator': instance.operator,
  'phoneNumber': instance.phoneNumber,
  'country': instance.country,
};
