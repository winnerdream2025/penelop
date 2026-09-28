import 'package:json_annotation/json_annotation.dart';
part 'set_pin.dto.g.dart';

@JsonSerializable()
class SetPinDto {
  final String  newCodePin;
  final String curentCodePin;


  SetPinDto({
    required this.curentCodePin,
    required this.newCodePin,

  });

  factory SetPinDto.fromJson(Map<String, dynamic> json) =>
      _$SetPinDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SetPinDtoToJson(this);
}
