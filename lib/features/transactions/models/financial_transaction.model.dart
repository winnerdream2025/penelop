import 'package:json_annotation/json_annotation.dart';

part 'financial_transaction.model.g.dart';

@JsonEnum(alwaysCreate: true)
enum TransactionType { DEPOSIT, WITHDRAWAL, TRANSFER, FEE, ADJUSTMENT }

@JsonEnum(alwaysCreate: true)
enum TransactionProvider { INTERNAL, PAYPAL, MOBILE_MONEY, CARD }

@JsonEnum(alwaysCreate: true)
enum TransactionStatus { PENDING, CONFIRM, SUCCESS, FAILED, CANCELED }

@JsonSerializable()
class FinancialTransaction {
  final String reference;
  final TransactionType type;
  final double amount;
  final double netAmount;
    final DateTime createdAt;
  final String status;
  final String name;
  final bool? isSender;


  FinancialTransaction({
    required this.reference,
    required this.type,
    required this.amount,
    required this.netAmount,
    required this.createdAt,
    required this.status ,
    required this.name,
     this.isSender = false


  });

  factory FinancialTransaction.fromJson(Map<String, dynamic> json) =>
      _$FinancialTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$FinancialTransactionToJson(this);
}
