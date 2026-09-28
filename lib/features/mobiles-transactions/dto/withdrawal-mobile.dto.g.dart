// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdrawal-mobile.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawalMobileDto _$WithdrawalMobileDtoFromJson(Map<String, dynamic> json) =>
    WithdrawalMobileDto(
      amount: (json['amount'] as num).toDouble(),
      phoneNumber: json['phoneNumber'] as String,
      country: json['country'] as String,
      operator: json['operator'] as String,
    );

Map<String, dynamic> _$WithdrawalMobileDtoToJson(
  WithdrawalMobileDto instance,
) => <String, dynamic>{
  'amount': instance.amount,
  'country': instance.country,
  'operator': instance.operator,
  'phoneNumber': instance.phoneNumber,
};
