import 'package:json_annotation/json_annotation.dart';

part 'create_update_pin.dto.g.dart';

@JsonSerializable()
class CreateUpdatePinDto {
  final String code;


  CreateUpdatePinDto({
    required this.code,

  });

  factory CreateUpdatePinDto.fromJson(Map<String, dynamic> json) =>
      _$CreateUpdatePinDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUpdatePinDtoToJson(this);
}
