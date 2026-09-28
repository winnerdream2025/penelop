import 'package:json_annotation/json_annotation.dart';
part 'mobile_withdrawal_preview_data.g.dart';

@JsonSerializable()
class MobileWithdrawalPreviewData {
  final double amount;
  final double amountToDebit;
  final double netAmount;
  final double providerFee;
  final double corisFee;
  final double totalFee;
  final String operator;
  final String phoneNumber;
  final String country;

  MobileWithdrawalPreviewData( {
    required this.amount,
    required this.netAmount,
    required this.providerFee,
    required this.corisFee,
    required this.totalFee,
    required this.operator,
    required this.phoneNumber,
    required this.country,
    required this.amountToDebit
  });

  factory MobileWithdrawalPreviewData.fromJson(Map<String, dynamic> json) =>
      _$MobileWithdrawalPreviewDataFromJson(json);

  Map<String, dynamic> toJson() => _$MobileWithdrawalPreviewDataToJson(this);
}
