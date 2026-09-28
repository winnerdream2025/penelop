import 'package:json_annotation/json_annotation.dart';

part 'create_intern_transaction.dto.g.dart';

@JsonSerializable()
class CreateInternTransactionDto {
  final double amount;
  final String to;


  CreateInternTransactionDto({
    required this.amount,
    required this.to,

  });

  factory CreateInternTransactionDto.fromJson(Map<String, dynamic> json) =>
      _$CreateInternTransactionDtoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CreateInternTransactionDtoToJson(this);


  CreateInternTransactionDto copyWith({
    double? amount,
    String? to,

  }) {
    return CreateInternTransactionDto(
      amount: amount ?? this.amount,
      to: to ?? this.to,
    );
  }
}
