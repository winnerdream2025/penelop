// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_qr_code_transfer_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckQrCodeTransferInfoModel _$CheckQrCodeTransferInfoModelFromJson(
  Map<String, dynamic> json,
) => CheckQrCodeTransferInfoModel(
  receiverFirstname: json['receiverFirstname'] as String,
  receiverLastname: json['receiverLastname'] as String,
  receiverAccountNumber: json['receiverAccountNumber'] as String,
  amount: (json['amount'] as num).toDouble(),
  receiverId: json['receiverId'] as String,
);

Map<String, dynamic> _$CheckQrCodeTransferInfoModelToJson(
  CheckQrCodeTransferInfoModel instance,
) => <String, dynamic>{
  'receiverFirstname': instance.receiverFirstname,
  'receiverLastname': instance.receiverLastname,
  'receiverAccountNumber': instance.receiverAccountNumber,
  'amount': instance.amount,
  'receiverId': instance.receiverId,
};
