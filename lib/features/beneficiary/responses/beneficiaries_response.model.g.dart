// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beneficiaries_response.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeneficiaryData _$BeneficiaryDataFromJson(Map<String, dynamic> json) =>
    BeneficiaryData(
      beneficiaries: (json['beneficiaries'] as List<dynamic>)
          .map((e) => Beneficiary.fromJson(e as Map<String, dynamic>))
          .toList(),
      contacts: (json['contacts'] as List<dynamic>)
          .map((e) => Beneficiary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BeneficiaryDataToJson(BeneficiaryData instance) =>
    <String, dynamic>{
      'beneficiaries': instance.beneficiaries,
      'contacts': instance.contacts,
    };

BeneficiariesResponse _$BeneficiariesResponseFromJson(
  Map<String, dynamic> json,
) => BeneficiariesResponse(
  message: json['message'] as String,
  status: json['status'] as bool,
  data: json['data'] == null
      ? null
      : BeneficiaryData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BeneficiariesResponseToJson(
  BeneficiariesResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};
