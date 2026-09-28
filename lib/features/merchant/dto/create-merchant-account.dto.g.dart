// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create-merchant-account.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateMerchantAccountDto _$CreateMerchantAccountDtoFromJson(
  Map<String, dynamic> json,
) => CreateMerchantAccountDto(
  designation: json['designation'] as String,
  address: json['address'] as String,
);

Map<String, dynamic> _$CreateMerchantAccountDtoToJson(
  CreateMerchantAccountDto instance,
) => <String, dynamic>{
  'designation': instance.designation,
  'address': instance.address,
};
