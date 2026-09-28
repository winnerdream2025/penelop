// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'otp_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$OtpService extends OtpService {
  _$OtpService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = OtpService;

  @override
  Future<Map<String, dynamic>> sendPhoneOtp(
    SendPhoneOtpDto sendPhoneOtpDto,
    String lang,
  ) async {
    final Uri $url = Uri.parse('/otp/send-phone');
    final Map<String, dynamic> $params = <String, dynamic>{'lang': lang};
    final $body = sendPhoneOtpDto;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> verifyOtp(
    VerifyOtpDto verifyOtpDto,
    String lang,
  ) async {
    final Uri $url = Uri.parse('/otp/verify');
    final Map<String, dynamic> $params = <String, dynamic>{'lang': lang};
    final $body = verifyOtpDto;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> sendResetOtp(
    SendPhoneOtpDto sendPhoneOtpDto,
  ) async {
    final Uri $url = Uri.parse('/otp/request-reset');
    final $body = sendPhoneOtpDto;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> sendEmailResetOtp(SendEmailOtpDto dto) async {
    final Uri $url = Uri.parse('/otp/send-request-email');
    final $body = dto;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> sendEmailOtp(SendEmailOtpDto dto) async {
    final Uri $url = Uri.parse('/otp/send-email');
    final $body = dto;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }
}
