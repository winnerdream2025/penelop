// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobile_recharge_preview_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MobileRechargePreviewResponse _$MobileRechargePreviewResponseFromJson(
  Map<String, dynamic> json,
) => MobileRechargePreviewResponse(
  data: json['data'] == null
      ? null
      : MobileRechargePreviewData.fromJson(
          json['data'] as Map<String, dynamic>,
        ),
  message: json['message'] as String,
  status: json['status'] as bool,
);

Map<String, dynamic> _$MobileRechargePreviewResponseToJson(
  MobileRechargePreviewResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'status': instance.status,
  'data': instance.data,
};
