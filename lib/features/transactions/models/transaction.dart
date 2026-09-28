import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction {
  final DateTime date;
  final String statut;
  final String type;
  final String name;
  final double montant;
  final String reference;
  final bool isSent;

  Transaction({
    required this.statut,
    required this.type,
    required this.name,
    required this.montant,
    required this.date,
    required this.reference,
    required this.isSent,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}