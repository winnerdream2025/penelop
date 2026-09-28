import 'package:corrispay/features/requests/models/user-request.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'requests.response.g.dart';

@JsonSerializable()
class RequestsResponse {
 final String message;
 final bool status;
 final List<UserRequest>? data;

  RequestsResponse({
    required this.message,
    required this.status,
     this.data,
  });

  factory RequestsResponse.fromJson(Map<String, dynamic> json) =>
      _$RequestsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RequestsResponseToJson(this);
}