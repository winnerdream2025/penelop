// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthData _$AuthDataFromJson(Map<String, dynamic> json) => AuthData(
  user: User.fromJson(json['user'] as Map<String, dynamic>),
  dashboardData: DashboardData.fromJson(
    json['dashboardData'] as Map<String, dynamic>,
  ),
  businessSettings: BusinessSettings.fromJson(
    json['businessSettings'] as Map<String, dynamic>,
  ),
  merchantAccount: json['merchantAccount'] == null
      ? null
      : MerchantAccountModel.fromJson(
          json['merchantAccount'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$AuthDataToJson(AuthData instance) => <String, dynamic>{
  'user': instance.user,
  'dashboardData': instance.dashboardData,
  'businessSettings': instance.businessSettings,
  'merchantAccount': instance.merchantAccount,
};
