import 'package:json_annotation/json_annotation.dart';

part 'add_mobile_money_to_wallet.dto.g.dart';

@JsonSerializable()
class AddMobileMoneyToWalletDto {
  final double amount;

  final String country;

  final String operator;

  final String phone;

  AddMobileMoneyToWalletDto({
    required this.amount,

    required this.phone,
    required this.country,
    required this.operator,
  });

  factory AddMobileMoneyToWalletDto.fromJson(Map<String, dynamic> json) =>
      _$AddMobileMoneyToWalletDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddMobileMoneyToWalletDtoToJson(this);


}
