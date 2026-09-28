// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'user-request.service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$UserRequestService extends UserRequestService {
  _$UserRequestService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = UserRequestService;

  @override
  Future<Map<String, dynamic>> confirmRequest(ConfirmRequestDto dto) async {
    final Uri $url = Uri.parse('/user-requests/confirm');
    final $body = dto;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> rejectRequest(String id) async {
    final Uri $url = Uri.parse('/user-requests/${id}/reject');
    final Request $request = Request('PATCH', $url, client.baseUrl);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> getRequests() async {
    final Uri $url = Uri.parse('/user-requests/me');
    final Request $request = Request('GET', $url, client.baseUrl);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }
}
