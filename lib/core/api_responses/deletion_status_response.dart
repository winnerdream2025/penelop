import 'package:json_annotation/json_annotation.dart';
part 'deletion_status_response.g.dart';

@JsonSerializable()
class DeletionStatusResponse {
  final bool status;
  final String message;
  final String? deletionRequestedAt;
  final String? deletionScheduledFor;

  DeletionStatusResponse({
    required this.status,
    required this.message,
    this.deletionRequestedAt,
    this.deletionScheduledFor,
  });

  factory DeletionStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$DeletionStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeletionStatusResponseToJson(this);
}
