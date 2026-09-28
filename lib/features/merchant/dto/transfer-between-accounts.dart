import 'package:json_annotation/json_annotation.dart';

part 'transfer-between-accounts.g.dart';

enum TransferDirection {
  @JsonValue('PERSONAL_TO_MERCHANT')
  personalToMerchant,
  @JsonValue('MERCHANT_TO_PERSONAL')
  merchantToPersonal,
}

@JsonSerializable()
class TransferBetweenAccountsDto {
  final TransferDirection direction;
  final double amount;

  TransferBetweenAccountsDto({
    required this.direction,
    required this.amount,
  });

  factory TransferBetweenAccountsDto.fromJson(Map<String, dynamic> json) =>
      _$TransferBetweenAccountsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TransferBetweenAccountsDtoToJson(this);
}