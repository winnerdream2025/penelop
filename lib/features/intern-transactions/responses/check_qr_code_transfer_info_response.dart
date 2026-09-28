import 'package:json_annotation/json_annotation.dart';

import '../../transactions/models/check_qr_code_transfer_info_model.dart';

part 'check_qr_code_transfer_info_response.g.dart';

@JsonSerializable()
class CheckQrCodeTransferInfoResponse {
 final bool status;
 final String message;
 final CheckQrCodeTransferInfoModel? data;


  CheckQrCodeTransferInfoResponse({
    required this.status,
    required this.message,
     this.data,
  });

  factory CheckQrCodeTransferInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckQrCodeTransferInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckQrCodeTransferInfoResponseToJson(this);
}
