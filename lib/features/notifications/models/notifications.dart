import 'package:json_annotation/json_annotation.dart';

part 'notifications.g.dart';

@JsonSerializable()
class NotificationData {
  final double amount;
  final String currency;
  final String name;

  const NotificationData({
    required this.amount,
    required this.currency,
    required this.name,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationDataToJson(this);
}

@JsonSerializable()
class NotificationModel {
  final String id;
  final String type;
  final NotificationData data;
  @JsonKey(name: 'isRead', defaultValue: false)
  final bool isRead;
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  const NotificationModel({
    required this.id,
    required this.type,
    required this.data,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
@JsonSerializable()
class NotificationsResponse {
  final String message;
  final bool status;
  final List<NotificationModel> data;

  const NotificationsResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsResponseToJson(this);
}

@JsonSerializable()
class UnreadCountResponse {
  final int count;

  const UnreadCountResponse({required this.count});

  factory UnreadCountResponse.fromJson(Map<String, dynamic> json) =>
      _$UnreadCountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UnreadCountResponseToJson(this);
}
