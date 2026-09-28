import 'package:corrispay/features/mobiles-transactions/responses/mobile_withdrawal_preview_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mobile_withdrawal_preview_response.g.dart';

@JsonSerializable()
class MobileWithdrawalPreviewResponse {
final String message;
final bool status;
final MobileWithdrawalPreviewData? data;

MobileWithdrawalPreviewResponse({
this.data,
required this.message,
required this.status
});

factory MobileWithdrawalPreviewResponse.fromJson(Map<String, dynamic> json) =>
_$MobileWithdrawalPreviewResponseFromJson(json);

Map<String, dynamic> toJson() => _$MobileWithdrawalPreviewResponseToJson(this);
}


