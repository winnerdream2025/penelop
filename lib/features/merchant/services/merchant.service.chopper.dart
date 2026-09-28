// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'merchant.service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$MerchantService extends MerchantService {
  _$MerchantService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = MerchantService;

  @override
  Future<Map<String, dynamic>> submitMerchantAccount(
    CreateMerchantAccountDto dto,
  ) async {
    final Uri $url = Uri.parse('/merchant-account');
    final $body = dto;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> interTransfer(
    TransferBetweenAccountsDto dto,
  ) async {
    final Uri $url = Uri.parse('/merchant-account/tranfer');
    final $body = dto;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> getAccounts() async {
    final Uri $url = Uri.parse('/merchant-account/accounts');
    final Request $request = Request('GET', $url, client.baseUrl);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }
}
