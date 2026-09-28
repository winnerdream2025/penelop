import 'package:json_annotation/json_annotation.dart';

part 'add_beneficiary.dto.g.dart';

@JsonSerializable()
class AddBeneficiaryDto {
  final String beneficiaryPhoneNumber;


  AddBeneficiaryDto({
    required this.beneficiaryPhoneNumber,
  });

  factory AddBeneficiaryDto.fromJson(Map<String, dynamic> json) =>
      _$AddBeneficiaryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddBeneficiaryDtoToJson(this);
}
