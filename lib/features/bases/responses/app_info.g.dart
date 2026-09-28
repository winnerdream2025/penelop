// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/app_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppInfo _$AppInfoFromJson(Map<String, dynamic> json) => AppInfo(
  platform: json['platform'] as String,
  min_version: json['min_version'] as String,
  latest_version: json['latest_version'] as String,
  force_update: json['force_update'] as bool,
);

Map<String, dynamic> _$AppInfoToJson(AppInfo instance) => <String, dynamic>{
  'platform': instance.platform,
  'min_version': instance.min_version,
  'latest_version': instance.latest_version,
  'force_update': instance.force_update,
};
