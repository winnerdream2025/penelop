import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'login_with_pin_dto.g.dart';

@JsonSerializable()
class LoginWithPinDto extends Equatable {
  final String? codePin;
  final bool biometricAuth;

  const LoginWithPinDto({
    this.codePin,
    required this.biometricAuth,
  });


  factory LoginWithPinDto.fromJson(Map<String, dynamic> json) =>
      _$LoginWithPinDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginWithPinDtoToJson(this);

  @override
  List<Object?> get props => [ codePin, biometricAuth];
}
