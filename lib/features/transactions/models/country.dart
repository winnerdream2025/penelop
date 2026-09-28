import 'package:json_annotation/json_annotation.dart';

import 'mobile_money.dart';
part 'country.g.dart';

@JsonSerializable()
class Country {
  final int id;
  final String countryCode;
  final String countryName;
  final String dialCode;
  final double limit;

  final List<MobileMoney> mobileMoneys;

  Country({
    required this.id,
    required this.countryCode,
    required this.countryName,
    required this.dialCode,
    required this.limit,

    required this.mobileMoneys,
  });

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);

  // Méthode copyWith
  Country copyWith({
    int? id,
    String? countryCode,
    String? countryName,
    String? dialCode,
    double? limit,

    List<MobileMoney>? mobileMoneys,
  }) {
    return Country(
      id: id ?? this.id,
      countryCode: countryCode ?? this.countryCode,
      countryName: countryName ?? this.countryName,
      dialCode: dialCode ?? this.dialCode,
      limit: limit ?? this.limit,

      mobileMoneys: mobileMoneys ?? this.mobileMoneys,
    );
  }
}
