// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm-withdrawal-mobile.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmWithdrawalMobileDto _$ConfirmWithdrawalMobileDtoFromJson(
  Map<String, dynamic> json,
) => ConfirmWithdrawalMobileDto(
  amount: (json['amount'] as num).toDouble(),
  phoneNumber: json['phoneNumber'] as String,
  country: json['country'] as String,
  operator: json['operator'] as String,
  codePin: json['codePin'] as String?,
  biometricAuth: json['biometricAuth'] as bool,
);

Map<String, dynamic> _$ConfirmWithdrawalMobileDtoToJson(
  ConfirmWithdrawalMobileDto instance,
) => <String, dynamic>{
  'amount': instance.amount,
  'country': instance.country,
  'operator': instance.operator,
  'phoneNumber': instance.phoneNumber,
  'codePin': instance.codePin,
  'biometricAuth': instance.biometricAuth,
};
