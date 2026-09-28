import 'package:corrispay/features/merchant/models/merchant-account-model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'merchant_response.g.dart';

@JsonSerializable()
class MerchantResponse {
  final bool status;
  final String message;
  final MerchantAccountModel? data;

  MerchantResponse({required this.message, required this.status, this.data});

  factory MerchantResponse.fromJson(Map<String, dynamic> json) =>
      _$MerchantResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantResponseToJson(this);
}



