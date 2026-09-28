// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_settings.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessSettings _$BusinessSettingsFromJson(Map<String, dynamic> json) =>
    BusinessSettings(
      minTransferAmount: (json['minTransferAmount'] as num).toDouble(),
      minWithdrawalAmount: (json['minWithdrawalAmount'] as num).toDouble(),
      minDepositAmount: (json['minDepositAmount'] as num).toDouble(),
      caurisTransferFees: (json['caurisTransferFees'] as num).toDouble(),
    );

Map<String, dynamic> _$BusinessSettingsToJson(BusinessSettings instance) =>
    <String, dynamic>{
      'minTransferAmount': instance.minTransferAmount,
      'minWithdrawalAmount': instance.minWithdrawalAmount,
      'minDepositAmount': instance.minDepositAmount,
      'caurisTransferFees': instance.caurisTransferFees,
    };
