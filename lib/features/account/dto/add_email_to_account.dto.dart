import 'package:json_annotation/json_annotation.dart';
part 'add_email_to_account.dto.g.dart';
@JsonSerializable()
class AddEmailToAccountDto {
  final String email;
  final String otp;


  AddEmailToAccountDto({
    required this.email,

    required this.otp,
  });

  factory AddEmailToAccountDto.fromJson(Map<String, dynamic> json) =>
      _$AddEmailToAccountDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddEmailToAccountDtoToJson(this);
}
