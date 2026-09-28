import 'package:json_annotation/json_annotation.dart';
import 'mobile_deposit_data.dart';
part 'mobile_deposit_response.g.dart';

@JsonSerializable()
class MobileDepositResponse{
  final String message;
  final bool status;
  final MobileDepositData? data;

  MobileDepositResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory MobileDepositResponse.fromJson(Map<String, dynamic> json) =>
      _$MobileDepositResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MobileDepositResponseToJson(this);
}