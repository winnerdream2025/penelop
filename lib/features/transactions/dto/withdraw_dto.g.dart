// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdraw_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawDto _$WithdrawDtoFromJson(Map<String, dynamic> json) => WithdrawDto(
  amount: (json['amount'] as num).toDouble(),
  operator: json['operator'] as String,
  country: json['country'] as String,
  phoneNumber: json['phoneNumber'] as String,
);

Map<String, dynamic> _$WithdrawDtoToJson(WithdrawDto instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'country': instance.country,
      'phoneNumber': instance.phoneNumber,
      'operator': instance.operator,
    };
