import 'package:json_annotation/json_annotation.dart';

part 'withdrawal_model.g.dart';

@JsonSerializable()
class WithdrawalModel {
  final String reference;
  final double amount;
  final String status;
  final String phone;
  final String provider;
  final double providerFee;
  final double corisFee;
  final String account;
  final String receiverCurrency;
  final double receiverExchangeRate;

  WithdrawalModel({
    required this.reference,
    required this.amount,
    required this.status,
    required this.phone,
    required this.provider,
    required this.providerFee,
    required this.corisFee,
    required this.account,
    required this.receiverCurrency,
    required this.receiverExchangeRate,
  });

  factory WithdrawalModel.fromJson(Map<String, dynamic> json) =>
      _$WithdrawalModelFromJson(json);

  Map<String, dynamic> toJson() => _$WithdrawalModelToJson(this);
}
