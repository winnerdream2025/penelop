// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
  id: (json['id'] as num).toInt(),
  countryCode: json['countryCode'] as String,
  countryName: json['countryName'] as String,
  dialCode: json['dialCode'] as String,
  limit: (json['limit'] as num).toDouble(),
  mobileMoneys: (json['mobileMoneys'] as List<dynamic>)
      .map((e) => MobileMoney.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
  'id': instance.id,
  'countryCode': instance.countryCode,
  'countryName': instance.countryName,
  'dialCode': instance.dialCode,
  'limit': instance.limit,
  'mobileMoneys': instance.mobileMoneys,
};
