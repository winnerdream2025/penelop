// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobile_money.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MobileMoney _$MobileMoneyFromJson(Map<String, dynamic> json) => MobileMoney(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  provider: json['provider'] as String,
);

Map<String, dynamic> _$MobileMoneyToJson(MobileMoney instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'provider': instance.provider,
    };
