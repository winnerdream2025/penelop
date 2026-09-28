// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intern-transfer.response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InterTransferData _$InterTransferDataFromJson(Map<String, dynamic> json) =>
    InterTransferData(
      dashboardData: DashboardData.fromJson(
        json['dashboardData'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$InterTransferDataToJson(InterTransferData instance) =>
    <String, dynamic>{'dashboardData': instance.dashboardData};

InterTransferResponse _$InterTransferResponseFromJson(
  Map<String, dynamic> json,
) => InterTransferResponse(
  message: json['message'] as String,
  status: json['status'] as bool,
  data: json['data'] == null
      ? null
      : DashboardData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$InterTransferResponseToJson(
  InterTransferResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};
