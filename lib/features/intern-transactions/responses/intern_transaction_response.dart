import 'package:corrispay/features/transactions/models/intern_transaction.dart';
import 'package:json_annotation/json_annotation.dart';

part 'intern_transaction_response.g.dart';

@JsonSerializable()
class InternTransactionResponse {
 final String message;
 final bool status;
 final InternTransaction? data;

  InternTransactionResponse({
    this.data,
    required this.message,
    required this.status
  });

  factory InternTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$InternTransactionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InternTransactionResponseToJson(this);
}
