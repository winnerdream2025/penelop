import 'package:json_annotation/json_annotation.dart';


part 'dashboard_data.g.dart';

@JsonSerializable()
class DashboardData {
  final double balance;
  final double? merchantBalance;

  DashboardData({required this.balance,  this.merchantBalance });

  factory DashboardData.fromJson(Map<String, dynamic> json) =>
      _$DashboardDataFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardDataToJson(this);
}
