import 'package:json_annotation/json_annotation.dart';
part 'send-phone-otp.dto.g.dart';

@JsonSerializable()
class SendPhoneOtpDto {
  final String phoneNumber;

  SendPhoneOtpDto({required this.phoneNumber});

  factory SendPhoneOtpDto.fromJson(Map<String, dynamic> json) =>
      _$SendPhoneOtpDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SendPhoneOtpDtoToJson(this);
}