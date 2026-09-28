// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardData _$DashboardDataFromJson(Map<String, dynamic> json) =>
    DashboardData(
      balance: (json['balance'] as num).toDouble(),
      merchantBalance: (json['merchantBalance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DashboardDataToJson(DashboardData instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'merchantBalance': instance.merchantBalance,
    };
