import 'package:json_annotation/json_annotation.dart';
part 'check_qr_code_info_dto.g.dart';

@JsonSerializable()
class CheckQrCodeInfoDto {

  final String receiverId;


  final String amount;


  CheckQrCodeInfoDto({
    required this.receiverId,
    required this.amount,

  });

  factory CheckQrCodeInfoDto.fromJson(Map<String, dynamic> json) =>
      _$CheckQrCodeInfoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CheckQrCodeInfoDtoToJson(this);

}
