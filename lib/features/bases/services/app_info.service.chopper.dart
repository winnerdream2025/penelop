// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'app_info.service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$AppConfigService extends AppConfigService {
  _$AppConfigService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = AppConfigService;

  @override
  Future<Map<String, dynamic>> getPlatformInfo(String platform) async {
    final Uri $url = Uri.parse('/app-config/${platform}');
    final Request $request = Request('GET', $url, client.baseUrl);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }
}
