import 'package:json_annotation/json_annotation.dart';

part 'exchange_rate.g.dart';

@JsonSerializable(explicitToJson: true)
class ExchangeRate {
  final String targetCurrency;

  final String rate;

  ExchangeRate({required this.targetCurrency, required this.rate});

  factory ExchangeRate.fromJson(Map<String, dynamic> json) =>
      _$ExchangeRateFromJson(json);

  Map<String, dynamic> toJson() => _$ExchangeRateToJson(this);
}
