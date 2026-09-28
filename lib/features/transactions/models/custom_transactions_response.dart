import 'package:corrispay/features/transactions/models/transaction.dart';
import 'package:json_annotation/json_annotation.dart';
part 'custom_transactions_response.g.dart';

@JsonSerializable()
class CustomTransactionsResponse {
  final String message;
  final bool status;
  final TransactionsPageData? data;

  CustomTransactionsResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory CustomTransactionsResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomTransactionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomTransactionsResponseToJson(this);
}


@JsonSerializable()
class TransactionsPageData {
  final List<Transaction> items;
  final int total;
  final int page;
  final int limit;
  final int totalPages;
  final bool hasMore;

  TransactionsPageData({
    required this.items,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.hasMore,
  });

  factory TransactionsPageData.fromJson(Map<String, dynamic> json) =>
      _$TransactionsPageDataFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionsPageDataToJson(this);
}