import 'package:json_annotation/json_annotation.dart';

part 'user-request.model.g.dart';

@JsonSerializable()
class UserRequest {
  final String id;
  final String reference;
  final String type; // "WITHDRAWAL" | "PAYMENT"
  final String name;
  final String amount;
  final String currency;
  final String status;
  final DateTime expiresAt;

  UserRequest({
    required this.id,
    required this.reference,
    required this.type,
    required this.name,
    required this.amount,
    required this.currency,
    required this.status,
    required this.expiresAt,
  });

  factory UserRequest.fromJson(Map<String, dynamic> json){
    print("json");
    print(json);
   return _$UserRequestFromJson(json); 
  }

  Map<String, dynamic> toJson() => _$UserRequestToJson(this);
}