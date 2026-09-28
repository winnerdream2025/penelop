import 'package:json_annotation/json_annotation.dart';
part 'confirm-withdrawal-mobile.dto.g.dart';

@JsonSerializable()
class ConfirmWithdrawalMobileDto {
  final double amount;
  final String country;
  final String operator;
  final String phoneNumber;
  final String? codePin;
  final bool biometricAuth;


  ConfirmWithdrawalMobileDto({
    required this.amount,
    required this.phoneNumber,
    required this.country,
    required this.operator,
    required this.codePin,
    required this.biometricAuth,
  });

  factory ConfirmWithdrawalMobileDto.fromJson(Map<String, dynamic> json) =>
      _$ConfirmWithdrawalMobileDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmWithdrawalMobileDtoToJson(this);


}
