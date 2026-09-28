// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'notifications.service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$NotificationsService extends NotificationsService {
  _$NotificationsService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = NotificationsService;

  @override
  Future<Map<String, dynamic>> getNotifications() async {
    final Uri $url = Uri.parse('/notifications/');
    final Request $request = Request('GET', $url, client.baseUrl);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }
}
