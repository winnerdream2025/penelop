// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'beneficiary.service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$BeneficiaryService extends BeneficiaryService {
  _$BeneficiaryService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = BeneficiaryService;

  @override
  Future<Map<String, dynamic>> getBeneficiaries(
    GetReceiverSuggestionsDto dto,
  ) async {
    final Uri $url = Uri.parse('/beneficiary/receiver-suggestions');
    final $body = dto;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> addBeneficiary(AddBeneficiaryDto dto) async {
    final Uri $url = Uri.parse('/beneficiary');
    final $body = dto;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> getBeneficiaryById(String id) async {
    final Uri $url = Uri.parse('/beneficiary/${id}');
    final Request $request = Request('GET', $url, client.baseUrl);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> checkBeneficiary(String phoneNumber) async {
    final Uri $url = Uri.parse('/beneficiary/check-beneficiary/${phoneNumber}');
    final Request $request = Request('GET', $url, client.baseUrl);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> checkBeneficiaryByQrCode(
    String beneficiaryId,
  ) async {
    final Uri $url = Uri.parse(
      '/beneficiary/check-beneficiary-qrcode/${beneficiaryId}',
    );
    final Request $request = Request('GET', $url, client.baseUrl);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }
}
