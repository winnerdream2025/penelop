import 'package:json_annotation/json_annotation.dart';
part 'withdrawal-mobile.dto.g.dart';

@JsonSerializable()
class WithdrawalMobileDto {
  final double amount;
  final String country;
  final String operator;
  final String phoneNumber;

  WithdrawalMobileDto({
    required this.amount,

    required this.phoneNumber,
    required this.country,
    required this.operator,
  });

  factory WithdrawalMobileDto.fromJson(Map<String, dynamic> json) =>
      _$WithdrawalMobileDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WithdrawalMobileDtoToJson(this);


}
