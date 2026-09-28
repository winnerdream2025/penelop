import 'package:corrispay/features/bases/models/dashboard_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'withdrawal_response.g.dart';

@JsonSerializable()
class WithdrawalResponse {
  final String message;
  final bool status;
  final DashboardData? data;

  WithdrawalResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory WithdrawalResponse.fromJson(Map<String, dynamic> json) => _$WithdrawalResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WithdrawalResponseToJson(this);
}
