import 'package:json_annotation/json_annotation.dart';

import '../models/auth_data.dart';

part 'auth_api_response.g.dart';

@JsonSerializable()
class AuthResponse {
  final bool status;
  final String message;
  final AuthData? data;

  AuthResponse({required this.message, required this.status, this.data});

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}



