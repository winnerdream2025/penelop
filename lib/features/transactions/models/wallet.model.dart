import 'package:json_annotation/json_annotation.dart';

part 'wallet.model.g.dart';

@JsonSerializable()
class Wallet {
  final double balance;

   final String accountNumber;
      final String userId;


  Wallet({required this.balance, required this.userId, required this.accountNumber});

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);

  Map<String, dynamic> toJson() => _$WalletToJson(this);
}
