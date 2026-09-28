import 'package:json_annotation/json_annotation.dart';

@JsonEnum(alwaysCreate: true)
enum UserStatus {
  ACTIVE,
  SUSPENDED,
  BLOCKED,
}

@JsonEnum(alwaysCreate: true)
enum KycLevel {
  NONE,
  BASIC,
  FULL,
}
