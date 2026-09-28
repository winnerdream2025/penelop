import 'package:corrispay/features/transactions/models/add_money_to_wallet_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'mobile_recharge_preview_data.dart';

part 'mobile_recharge_preview_response.g.dart';

@JsonSerializable()
class MobileRechargePreviewResponse {
  final String message;
  final bool status;
  final MobileRechargePreviewData? data;

  MobileRechargePreviewResponse ({
    this.data,
    required this.message,
    required this.status
  });

  factory  MobileRechargePreviewResponse.fromJson(Map<String, dynamic> json) =>
      _$MobileRechargePreviewResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MobileRechargePreviewResponseToJson(this);
}


