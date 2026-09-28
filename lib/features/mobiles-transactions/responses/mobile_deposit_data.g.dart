// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobile_deposit_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MobileDepositData _$MobileDepositDataFromJson(Map<String, dynamic> json) =>
    MobileDepositData(
      message: json['message'] as String,
      reference: json['reference'] as String,
      amount: (json['amount'] as num).toDouble(),
      status: json['status'] as String,
      phone: json['phone'] as String,
      operator: json['operator'] as String,
      providerFee: (json['providerFee'] as num).toDouble(),
      corisFee: (json['corisFee'] as num).toDouble(),
      account: json['account'] as String,
      netAmount: (json['netAmount'] as num).toDouble(),
    );

Map<String, dynamic> _$MobileDepositDataToJson(MobileDepositData instance) =>
    <String, dynamic>{
      'message': instance.message,
      'reference': instance.reference,
      'amount': instance.amount,
      'status': instance.status,
      'phone': instance.phone,
      'operator': instance.operator,
      'providerFee': instance.providerFee,
      'corisFee': instance.corisFee,
      'account': instance.account,
      'netAmount': instance.netAmount,
    };
