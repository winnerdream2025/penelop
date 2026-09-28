import 'package:json_annotation/json_annotation.dart';
part 'user.model.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String? email;
  final String firstName;
  final String lastName;
  final String country;
  final String phoneNumber;
  final String token;
  final bool hasCodePin;
  final String targetCurrency;
  final double  currencyRate;
  final bool? hasMerchantAccount;
  final String? deletionRequestedAt;
  final String? deletionScheduledFor;

  User({
    required this.id,
    this.email,
    required this.firstName,
    required this.lastName,
    required this.country,
    required this.phoneNumber,
    required this.token,
    required this.hasCodePin,
    required this.targetCurrency,
    required this.currencyRate,
    this.hasMerchantAccount = false,
    this.deletionRequestedAt,
    this.deletionScheduledFor,
  });

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({ String? newEmail, bool? hasCodePin, bool? hasMerchantAccount}) {
    return User(
      id: id,
      firstName: firstName,
      lastName: lastName,
      country: country,
      phoneNumber: phoneNumber,
      currencyRate: currencyRate,
      targetCurrency: targetCurrency,
      token: token,
      email: newEmail ?? email,
      hasCodePin: hasCodePin ?? this.hasCodePin,
      hasMerchantAccount: hasMerchantAccount ?? this.hasMerchantAccount,
      deletionRequestedAt: deletionRequestedAt,
      deletionScheduledFor: deletionScheduledFor,
    );
  }
}
