import 'package:json_annotation/json_annotation.dart';
import '../../bases/models/dashboard_data.dart';

part 'confirm_transaction_response.g.dart';

@JsonSerializable()
class ConfirmTransactionResponse {
  final bool status;
  final String message;
  final DashboardData? data;

  ConfirmTransactionResponse({
    required this.message,
    required this.status,
    this.data,
  });

  factory ConfirmTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$ConfirmTransactionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmTransactionResponseToJson(this);
}

