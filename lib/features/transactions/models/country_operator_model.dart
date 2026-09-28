import 'package:json_annotation/json_annotation.dart';

part 'country_operator_model.g.dart';

@JsonSerializable()
class CountryOperatorModel {
  final String label;
  final String key;
  final List<Operator> operators;
  final String countryCode;
  final String dialCode;
  final int phoneLength;

  CountryOperatorModel({
    required this.label,
    required this.key,
    required this.operators,
    required this.countryCode,
    required this.dialCode,
    required this.phoneLength,
  });

  factory CountryOperatorModel.fromJson(Map<String, dynamic> json) =>
      _$CountryOperatorModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryOperatorModelToJson(this);
}

@JsonSerializable()
class Operator {
  final String label;
  final String key;
  final String withdrawMode;
  final String url;
  final double totalPayoutFees;
  final double totalPinFees;

  Operator({
    required this.label,
    required this.key,
    required this.withdrawMode,
    required this.url,
    required this.totalPayoutFees,
    required this.totalPinFees,
  });

  factory Operator.fromJson(Map<String, dynamic> json) =>
      _$OperatorFromJson(json);

  Map<String, dynamic> toJson() => _$OperatorToJson(this);
}
