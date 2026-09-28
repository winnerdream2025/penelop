import 'package:json_annotation/json_annotation.dart';
part 'intern_transaction.g.dart';

@JsonSerializable()
class InternTransaction {
  final double amount;
  final double netAmount;
  final double corisFee;
  final String recipientFirstName;
  final String recipientLastName;
  final String recipientPhoneNumber;
  final double amountReceived;
  final String recipientCurrency;
  final String to;
  final double originalAmount; // Nouveau champ

  InternTransaction({
    required this.amount,
    required this.netAmount,
    required this.corisFee,
    required this.recipientFirstName,
    required this.recipientLastName,
    required this.recipientPhoneNumber,
    required this.amountReceived,
    required this.recipientCurrency,
    required this.to, // Ajout du champ
    required this.originalAmount, // Ajout du champ
  });

  factory InternTransaction.fromJson(Map<String, dynamic> json) =>
      _$InternTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$InternTransactionToJson(this);
}
