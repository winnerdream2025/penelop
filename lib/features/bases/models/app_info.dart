import 'package:json_annotation/json_annotation.dart';
part '../responses/app_info.g.dart';

@JsonSerializable()
class AppInfo {
  final String platform;
  final String min_version;
  final String latest_version;
  final bool force_update;
  final String? cachedAt;

  AppInfo({
    required this.platform,
    required this.min_version,
    required this.latest_version,
    required this.force_update,
    this.cachedAt,
  });

  bool get isCacheValid {
    if (cachedAt == null) return false;
    final cached = DateTime.tryParse(cachedAt!);
    if (cached == null) return false;
    final ttl = force_update
        ? const Duration(minutes: 15)
        : const Duration(minutes: 30);
    return DateTime.now().difference(cached).inMinutes < ttl.inMinutes;
  }

  AppInfo copyWithCachedAt(DateTime date) {
    return AppInfo(
      platform: platform,
      min_version: min_version,
      latest_version: latest_version,
      force_update: force_update,
      cachedAt: date.toIso8601String(),
    );
  }

  factory AppInfo.fromJson(Map<String, dynamic> json) =>
      _$AppInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AppInfoToJson(this);
}