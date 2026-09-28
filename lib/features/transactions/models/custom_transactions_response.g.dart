// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_transactions_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomTransactionsResponse _$CustomTransactionsResponseFromJson(
  Map<String, dynamic> json,
) => CustomTransactionsResponse(
  message: json['message'] as String,
  status: json['status'] as bool,
  data: json['data'] == null
      ? null
      : TransactionsPageData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CustomTransactionsResponseToJson(
  CustomTransactionsResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'status': instance.status,
  'data': instance.data,
};

TransactionsPageData _$TransactionsPageDataFromJson(
  Map<String, dynamic> json,
) => TransactionsPageData(
  items: (json['items'] as List<dynamic>)
      .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: (json['total'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  hasMore: json['hasMore'] as bool,
);

Map<String, dynamic> _$TransactionsPageDataToJson(
  TransactionsPageData instance,
) => <String, dynamic>{
  'items': instance.items,
  'total': instance.total,
  'page': instance.page,
  'limit': instance.limit,
  'totalPages': instance.totalPages,
  'hasMore': instance.hasMore,
};
