import 'package:json_annotation/json_annotation.dart';
part 'verify_otp.dto.g.dart';

@JsonSerializable()
class VerifyOtpDto {
  final String code;
  final String identifier;

  VerifyOtpDto({required this.code, required this.identifier});

  factory VerifyOtpDto.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOtpDtoToJson(this);
}