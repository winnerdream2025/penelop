import 'package:corrispay/features/auth/models/business_settings.model.dart';
import 'package:corrispay/features/merchant/models/merchant-account-model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'user.model.dart';
import '../../bases/models/dashboard_data.dart';
part 'auth_data.g.dart';

@JsonSerializable()
class AuthData {
  final User user;
  final DashboardData dashboardData;
  final BusinessSettings businessSettings;
  final MerchantAccountModel? merchantAccount;

  AuthData({
    required this.user,
    required this.dashboardData,
    required this.businessSettings,
    this.merchantAccount,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) =>
      _$AuthDataFromJson(json);

  Map<String, dynamic> toJson() => _$AuthDataToJson(this);
}
