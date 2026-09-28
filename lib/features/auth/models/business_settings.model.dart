import 'package:json_annotation/json_annotation.dart';
part 'business_settings.model.g.dart';

@JsonSerializable()
class BusinessSettings {
  final double minTransferAmount;
  final double minWithdrawalAmount;
  final double minDepositAmount;
  final double caurisTransferFees;


  BusinessSettings({
    required this.minTransferAmount,
    required this.minWithdrawalAmount,
    required this.minDepositAmount,
    required this.caurisTransferFees,

});

  factory BusinessSettings.fromJson(Map<String, dynamic> json) =>
      _$BusinessSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessSettingsToJson(this);
}
