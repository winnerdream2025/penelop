// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_intern_transaction.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmInternTransactionDto _$ConfirmInternTransactionDtoFromJson(
  Map<String, dynamic> json,
) => ConfirmInternTransactionDto(
  amount: json['amount'] as String,
  to: json['to'] as String,
  codePin: json['codePin'] as String?,
  biometricAuth: json['biometricAuth'] as bool,
);

Map<String, dynamic> _$ConfirmInternTransactionDtoToJson(
  ConfirmInternTransactionDto instance,
) => <String, dynamic>{
  'amount': instance.amount,
  'to': instance.to,
  'codePin': instance.codePin,
  'biometricAuth': instance.biometricAuth,
};
