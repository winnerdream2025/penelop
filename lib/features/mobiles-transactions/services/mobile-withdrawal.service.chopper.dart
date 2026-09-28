// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'mobile-withdrawal.service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$MobileWithdrawalService extends MobileWithdrawalService {
  _$MobileWithdrawalService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = MobileWithdrawalService;

  @override
  Future<Map<String, dynamic>> previewWithdrawal(
    WithdrawalMobileDto dto,
  ) async {
    final Uri $url = Uri.parse('/withdrawal/preview-mobile-money');
    final $body = dto;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> confirmMobileWithdrawal(
    ConfirmWithdrawalMobileDto dto,
  ) async {
    final Uri $url = Uri.parse('/withdrawal/confirm');
    final $body = dto;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }
}
