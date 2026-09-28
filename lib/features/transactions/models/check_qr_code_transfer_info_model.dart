import 'package:json_annotation/json_annotation.dart';

part 'check_qr_code_transfer_info_model.g.dart';

@JsonSerializable()
class CheckQrCodeTransferInfoModel {
  final String receiverFirstname;
  final String receiverLastname;
  final String receiverAccountNumber;
  final double amount;
  final String receiverId;

  CheckQrCodeTransferInfoModel({
    required this.receiverFirstname,
    required this.receiverLastname,
    required this.receiverAccountNumber,
    required this.amount,
    required this.receiverId,
  });

  factory CheckQrCodeTransferInfoModel.fromJson(Map<String, dynamic> json) =>
      _$CheckQrCodeTransferInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckQrCodeTransferInfoModelToJson(this);
}
