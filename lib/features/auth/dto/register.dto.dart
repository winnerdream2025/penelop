import 'package:json_annotation/json_annotation.dart';

part 'register.dto.g.dart';

@JsonSerializable()
class RegisterDto {
  final String? password;
  final String? firstName;
  final String? lastName;
  final String? country;
  final String? phoneNumber;
  final String? fcmToken;

  RegisterDto({

    this.password,
    this.firstName,
    this.lastName,
    this.country,
    this.phoneNumber,
    this.fcmToken,
  });

  factory RegisterDto.fromJson(Map<String, dynamic> json) =>
      _$RegisterDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterDtoToJson(this);

  RegisterDto copyWith({
    String? password,
    String? firstName,
    String? lastName,
    String? country,
    String? phoneNumber,
    String? fcmToken,
  }) {
    return RegisterDto(
      password: password ?? this.password,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      country: country ?? this.country,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }
}
