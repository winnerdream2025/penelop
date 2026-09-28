import 'package:json_annotation/json_annotation.dart';
part 'send-email-otp.dto.g.dart';

@JsonSerializable()
class SendEmailOtpDto {
  final String email;

  SendEmailOtpDto({required this.email});

  factory SendEmailOtpDto.fromJson(Map<String, dynamic> json) =>
      _$SendEmailOtpDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SendEmailOtpDtoToJson(this);
}