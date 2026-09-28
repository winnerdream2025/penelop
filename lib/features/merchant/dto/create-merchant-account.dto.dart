import 'package:json_annotation/json_annotation.dart';

part 'create-merchant-account.dto.g.dart';

@JsonSerializable()
class CreateMerchantAccountDto{
  final String designation;
  final String address;

  CreateMerchantAccountDto({
   required this.designation,
    required this.address

  });

  factory CreateMerchantAccountDto.fromJson(Map<String, dynamic> json) =>
      _$CreateMerchantAccountDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateMerchantAccountDtoToJson(this);
}
