// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: json['id'] as String,
  email: json['email'] as String?,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  country: json['country'] as String,
  phoneNumber: json['phoneNumber'] as String,
  token: json['token'] as String,
  hasCodePin: json['hasCodePin'] as bool,
  targetCurrency: json['targetCurrency'] as String,
  currencyRate: (json['currencyRate'] as num).toDouble(),
  hasMerchantAccount: json['hasMerchantAccount'] as bool? ?? false,
  deletionRequestedAt: json['deletionRequestedAt'] as String?,
  deletionScheduledFor: json['deletionScheduledFor'] as String?,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'country': instance.country,
  'phoneNumber': instance.phoneNumber,
  'token': instance.token,
  'hasCodePin': instance.hasCodePin,
  'targetCurrency': instance.targetCurrency,
  'currencyRate': instance.currencyRate,
  'hasMerchantAccount': instance.hasMerchantAccount,
  'deletionRequestedAt': instance.deletionRequestedAt,
  'deletionScheduledFor': instance.deletionScheduledFor,
};
