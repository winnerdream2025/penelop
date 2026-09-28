import 'package:json_annotation/json_annotation.dart';

part 'beneficiary.model.g.dart';

@JsonSerializable()
class Beneficiary {
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String? savedAs;

  Beneficiary({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.savedAs,
  });

  factory Beneficiary.fromJson(Map<String, dynamic> json) =>
      _$BeneficiaryFromJson(json);

  Map<String, dynamic> toJson() => _$BeneficiaryToJson(this);
}
