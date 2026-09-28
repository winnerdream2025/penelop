// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beneficiary_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeneficiaryResponse _$BeneficiaryResponseFromJson(Map<String, dynamic> json) =>
    BeneficiaryResponse(
      message: json['message'] as String,
      status: json['status'] as bool,
      data: json['data'] == null
          ? null
          : Beneficiary.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BeneficiaryResponseToJson(
  BeneficiaryResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};
