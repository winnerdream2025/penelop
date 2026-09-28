import 'package:json_annotation/json_annotation.dart';
part 'confirm_intern_transaction.dto.g.dart';

@JsonSerializable()
class ConfirmInternTransactionDto {
  final String amount;
  final String to;
  final String? codePin;
  final bool biometricAuth;

  ConfirmInternTransactionDto({
    required this.amount,
    required this.to,
    required this.codePin,
    required this.biometricAuth,
  });

  factory ConfirmInternTransactionDto.fromJson(Map<String, dynamic> json) =>
      _$ConfirmInternTransactionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmInternTransactionDtoToJson(this);
}
