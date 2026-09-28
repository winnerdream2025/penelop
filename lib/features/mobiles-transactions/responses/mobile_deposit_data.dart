import 'package:json_annotation/json_annotation.dart';
part 'mobile_deposit_data.g.dart';


@JsonSerializable()
class MobileDepositData {
  final String message;
  final String reference;
  final double amount;
  final String status;
  final String phone;
  final String operator;
  final double providerFee;
  final double corisFee;
  final String account;
  final double netAmount;

  MobileDepositData({
    required this.message,
    required this.reference,
    required this.amount,
    required this.status,
    required this.phone,
    required this.operator,
    required this.providerFee,
    required this.corisFee,
    required this.account,
    required this.netAmount,
  });

  factory MobileDepositData.fromJson(Map<String, dynamic> json) =>
      _$MobileDepositDataFromJson(json);

  Map<String, dynamic> toJson() => _$MobileDepositDataToJson(this);
}
