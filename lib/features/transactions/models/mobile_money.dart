import 'package:json_annotation/json_annotation.dart';
import 'country.dart';
part 'mobile_money.g.dart';

@JsonSerializable()
class MobileMoney {
  final int id;
  final String name;
  final String provider;



  MobileMoney({
    required this.id,
    required this.name,
    required this.provider,

  });

  factory MobileMoney.fromJson(Map<String, dynamic> json) => _$MobileMoneyFromJson(json);

  Map<String, dynamic> toJson() => _$MobileMoneyToJson(this);


  MobileMoney copyWith({
    int? id,
    String? name,
    String? provider,
    Country? country,
  }) {
    return MobileMoney(
      id: id ?? this.id,
      name: name ?? this.name,
      provider: provider ?? this.provider,

    );
  }
}
