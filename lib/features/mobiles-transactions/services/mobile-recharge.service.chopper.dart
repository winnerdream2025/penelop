// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'mobile-recharge.service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$MobileRechargeService extends MobileRechargeService {
  _$MobileRechargeService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = MobileRechargeService;

  @override
  Future<Map<String, dynamic>> previewMobileRecharge(
    AddMobileMoneyToWalletDto addMobileMoneyToWallet,
  ) async {
    final Uri $url = Uri.parse('/mobile-recharge/preview');
    final $body = addMobileMoneyToWallet;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> confirmMobileRecharge(
    AddMobileMoneyToWalletDto dto,
  ) async {
    final Uri $url = Uri.parse('/mobile-recharge/confirm');
    final $body = dto;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }
}
