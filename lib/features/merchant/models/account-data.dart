import 'package:json_annotation/json_annotation.dart';

part 'account-data.g.dart';

@JsonSerializable()
class Account {
  final String name;
  final double balance;

  Account({required this.name, required this.balance});

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}

@JsonSerializable()
class TransferAccountsData {
  final Account personalAccount;


  final Account? merchantAccount;

  TransferAccountsData({
    required this.personalAccount,
    this.merchantAccount,
  });

  factory TransferAccountsData.fromJson(Map<String, dynamic> json) =>
      _$TransferAccountsDataFromJson(json);

  Map<String, dynamic> toJson() => _$TransferAccountsDataToJson(this);
}