import 'package:json_annotation/json_annotation.dart';

import '../../beneficiary/models/beneficiary.model.dart';
part 'beneficiary_response.g.dart';

@JsonSerializable()
class BeneficiaryResponse {
  final bool status;
  final String message;
  final Beneficiary? data;

  BeneficiaryResponse({required this.message, required this.status, this.data});

  factory BeneficiaryResponse.fromJson(Map<String, dynamic> json) =>
      _$BeneficiaryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BeneficiaryResponseToJson(this);
}