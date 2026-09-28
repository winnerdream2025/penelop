import 'package:json_annotation/json_annotation.dart';
part 'confirm-request.dto.g.dart';

@JsonSerializable()
class ConfirmRequestDto {
  final String pin;
  final String requestId;

  ConfirmRequestDto({required this.pin, required this.requestId});

  factory ConfirmRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ConfirmRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmRequestDtoToJson(this);
}
