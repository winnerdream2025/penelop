// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_qr_code_transfer_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckQrCodeTransferInfoResponse _$CheckQrCodeTransferInfoResponseFromJson(
  Map<String, dynamic> json,
) => CheckQrCodeTransferInfoResponse(
  status: json['status'] as bool,
  message: json['message'] as String,
  data: json['data'] == null
      ? null
      : CheckQrCodeTransferInfoModel.fromJson(
          json['data'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$CheckQrCodeTransferInfoResponseToJson(
  CheckQrCodeTransferInfoResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};
