import 'package:json_annotation/json_annotation.dart';
import '../models/beneficiary.model.dart';
part 'beneficiaries_response.model.g.dart';

@JsonSerializable()
class BeneficiaryData {
  final List<Beneficiary> beneficiaries;
  final List<Beneficiary> contacts;

  BeneficiaryData({required this.beneficiaries, required this.contacts});

  factory BeneficiaryData.fromJson(Map<String, dynamic> json) =>
      _$BeneficiaryDataFromJson(json);

  Map<String, dynamic> toJson() => _$BeneficiaryDataToJson(this);
}

@JsonSerializable()
class BeneficiariesResponse {
  final bool status;
  final String message;
  final BeneficiaryData? data;

  BeneficiariesResponse({
    required this.message,
    required this.status,
    this.data,
  });

  factory BeneficiariesResponse.fromJson(Map<String, dynamic> json) =>
      _$BeneficiariesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BeneficiariesResponseToJson(this);
}
