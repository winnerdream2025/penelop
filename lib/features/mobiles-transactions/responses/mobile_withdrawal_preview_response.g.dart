// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobile_withdrawal_preview_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MobileWithdrawalPreviewResponse _$MobileWithdrawalPreviewResponseFromJson(
  Map<String, dynamic> json,
) => MobileWithdrawalPreviewResponse(
  data: json['data'] == null
      ? null
      : MobileWithdrawalPreviewData.fromJson(
          json['data'] as Map<String, dynamic>,
        ),
  message: json['message'] as String,
  status: json['status'] as bool,
);

Map<String, dynamic> _$MobileWithdrawalPreviewResponseToJson(
  MobileWithdrawalPreviewResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'status': instance.status,
  'data': instance.data,
};
