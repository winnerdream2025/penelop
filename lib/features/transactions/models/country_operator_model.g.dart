// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_operator_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryOperatorModel _$CountryOperatorModelFromJson(
  Map<String, dynamic> json,
) => CountryOperatorModel(
  label: json['label'] as String,
  key: json['key'] as String,
  operators: (json['operators'] as List<dynamic>)
      .map((e) => Operator.fromJson(e as Map<String, dynamic>))
      .toList(),
  countryCode: json['countryCode'] as String,
  dialCode: json['dialCode'] as String,
  phoneLength: (json['phoneLength'] as num).toInt(),
);

Map<String, dynamic> _$CountryOperatorModelToJson(
  CountryOperatorModel instance,
) => <String, dynamic>{
  'label': instance.label,
  'key': instance.key,
  'operators': instance.operators,
  'countryCode': instance.countryCode,
  'dialCode': instance.dialCode,
  'phoneLength': instance.phoneLength,
};

Operator _$OperatorFromJson(Map<String, dynamic> json) => Operator(
  label: json['label'] as String,
  key: json['key'] as String,
  withdrawMode: json['withdrawMode'] as String,
  url: json['url'] as String,
  totalPayoutFees: (json['totalPayoutFees'] as num).toDouble(),
  totalPinFees: (json['totalPinFees'] as num).toDouble(),
);

Map<String, dynamic> _$OperatorToJson(Operator instance) => <String, dynamic>{
  'label': instance.label,
  'key': instance.key,
  'withdrawMode': instance.withdrawMode,
  'url': instance.url,
  'totalPayoutFees': instance.totalPayoutFees,
  'totalPinFees': instance.totalPinFees,
};
