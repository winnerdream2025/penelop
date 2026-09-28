import 'package:json_annotation/json_annotation.dart';

part 'reset-code-pin.dto.g.dart';

@JsonSerializable()
class ResetCodePinDto {
  final String phoneNumber;

  final String newCodePin;

  ResetCodePinDto({
    required this.phoneNumber,

    required this.newCodePin,
  });

  factory ResetCodePinDto.fromJson(Map<String, dynamic> json) =>
      _$ResetCodePinDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ResetCodePinDtoToJson(this);
}
