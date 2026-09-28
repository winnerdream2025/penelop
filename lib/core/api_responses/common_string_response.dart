import 'package:json_annotation/json_annotation.dart';
part 'common_string_response.g.dart';

@JsonSerializable()
class CommonStringResponse {
  final bool status;
  final String message;
  final String? data;

  CommonStringResponse({required this.message, required this.status, this.data});

  factory CommonStringResponse.fromJson(Map<String, dynamic> json) =>
      _$CommonStringResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CommonStringResponseToJson(this);
}