import 'package:json_annotation/json_annotation.dart';


part 'merchant-account-model.g.dart';

@JsonSerializable()
class MerchantAccountModel {
  final double balance;
  final String designation;
  final String merchantCode;
  final String id;


  MerchantAccountModel({required this.balance, required this.designation, required this.id, required this.merchantCode });

  factory MerchantAccountModel.fromJson(Map<String, dynamic> json) =>
      _$MerchantAccountModelFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantAccountModelToJson(this);
}
