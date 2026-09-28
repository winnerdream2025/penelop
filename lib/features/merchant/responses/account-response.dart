import 'package:corrispay/features/merchant/models/account-data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account-response.g.dart';

@JsonSerializable()
class AccountResponse {
  final bool status;
  final String message;
  final TransferAccountsData? data;

  AccountResponse({required this.message, required this.status, this.data});

  factory AccountResponse.fromJson(Map<String, dynamic> json) =>
      _$AccountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AccountResponseToJson(this);
}
