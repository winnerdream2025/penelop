// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'transaction.service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$TransactionService extends TransactionService {
  _$TransactionService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = TransactionService;

  @override
  Future<Map<String, dynamic>> createInternTransaction(
    CreateInternTransactionDto createInternTransaction,
  ) async {
    final Uri $url = Uri.parse('/transactions/intern');
    final $body = createInternTransaction;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> confirmInternTransaction(
    ConfirmInternTransactionDto confirmInternTransaction,
  ) async {
    final Uri $url = Uri.parse('/transactions/confirm-intern');
    final $body = confirmInternTransaction;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> addMobileMoneyToWallet(
    AddMobileMoneyToWalletDto addMobileMoneyToWallet,
  ) async {
    final Uri $url = Uri.parse('/transactions/mobile-money');
    final $body = addMobileMoneyToWallet;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> withdrawMoneyToMobileMoney(
    WithdrawDto dto,
  ) async {
    final Uri $url = Uri.parse('/transactions/withdraw');
    final $body = dto;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> confirmWithdrawMoneyToMobileMoney(
    ConfirmInternTransactionDto dto,
  ) async {
    final Uri $url = Uri.parse('/transactions/withdraw/confirm');
    final $body = dto;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<List<dynamic>> getCountriesWithMobileMoney(
    String operationType,
  ) async {
    final Uri $url = Uri.parse('/transactions/country-list');
    final Map<String, dynamic> $params = <String, dynamic>{
      'operationType': operationType,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    final Response $response = await client.send<List<dynamic>, List<dynamic>>(
      $request,
    );
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> getTransactions(int page, int limit) async {
    final Uri $url = Uri.parse('/transactions/me');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> chekQrCodeInfo(CheckQrCodeInfoDto dto) async {
    final Uri $url = Uri.parse('/transactions/check-qrcode-info');
    final $body = dto;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }
}
