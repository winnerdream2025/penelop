// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantResponse _$MerchantResponseFromJson(Map<String, dynamic> json) =>
    MerchantResponse(
      message: json['message'] as String,
      status: json['status'] as bool,
      data: json['data'] == null
          ? null
          : MerchantAccountModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MerchantResponseToJson(MerchantResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
