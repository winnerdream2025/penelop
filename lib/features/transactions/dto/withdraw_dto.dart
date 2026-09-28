import 'package:json_annotation/json_annotation.dart';
part 'withdraw_dto.g.dart';

@JsonSerializable()
class WithdrawDto {
  final double amount;

  final String country;

  final String phoneNumber;

  final String operator;

  WithdrawDto({
    required this.amount,
    required this.operator,
    required this.country,
    required this.phoneNumber,
  });

  factory WithdrawDto.fromJson(Map<String, dynamic> json) =>
      _$WithdrawDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WithdrawDtoToJson(this);

  WithdrawDto copyWith({
    double? amount,
    String? country,
    String? operator,
    String? phoneNumber,
  }) {
    return WithdrawDto(
      amount: amount ?? this.amount,
      operator: operator ?? this.operator,
      country: country ?? this.country,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
