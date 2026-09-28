import 'package:corrispay/features/bases/models/dashboard_data.dart';
import 'package:corrispay/features/merchant/models/account-data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'intern-transfer.response.g.dart';

@JsonSerializable()
class InterTransferData {
  final DashboardData dashboardData;

  InterTransferData({required this.dashboardData});

  factory InterTransferData.fromJson(Map<String, dynamic> json) =>
      _$InterTransferDataFromJson(json);

  Map<String, dynamic> toJson() => _$InterTransferDataToJson(this);
}

@JsonSerializable()
class InterTransferResponse {
  final bool status;
  final String message;
  final DashboardData? data;

  InterTransferResponse({
    required this.message,
    required this.status,
    this.data,
  });

  factory InterTransferResponse.fromJson(Map<String, dynamic> json) =>
      _$InterTransferResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InterTransferResponseToJson(this);
}
