import 'package:json_annotation/json_annotation.dart';
part 'mobile_recharge_preview_data.g.dart';

@JsonSerializable()
class MobileRechargePreviewData {
  final double amount;
  final double netAmount;
  final double providerFee;
  final double corisFee;
  final double totalFee;
  final String operator;
  final String phoneNumber;
  final String country;

  MobileRechargePreviewData({
    required this.amount,
    required this.netAmount,
    required this.providerFee,
    required this.corisFee,
    required this.totalFee,
    required this.operator,
    required this.phoneNumber,
    required this.country,
  });

  factory MobileRechargePreviewData.fromJson(Map<String, dynamic> json) =>
      _$MobileRechargePreviewDataFromJson(json);

  Map<String, dynamic> toJson() => _$MobileRechargePreviewDataToJson(this);
}
