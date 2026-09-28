import 'package:json_annotation/json_annotation.dart';

part 'add_money_to_wallet_model.g.dart';

@JsonSerializable()
class AddMoneyToWalletModel {
  final String reference;
  final double amount;
  final String status;
  final String phone;
  final String provider;
  final double providerFee;
  final double corisFee;
  final String account;

  AddMoneyToWalletModel({
    required this.reference,
    required this.amount,
    required this.status,
    required this.phone,
    required this.provider,
    required this.providerFee,
    required this.corisFee,
    required this.account,
  });

  factory AddMoneyToWalletModel.fromJson(Map<String, dynamic> json) =>
      _$AddMoneyToWalletModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddMoneyToWalletModelToJson(this);
}
