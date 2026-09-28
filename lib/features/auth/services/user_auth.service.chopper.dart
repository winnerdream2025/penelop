// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'user_auth.service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$UserAuthService extends UserAuthService {
  _$UserAuthService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = UserAuthService;

  @override
  Future<Map<String, dynamic>> register(RegisterDto registerDto) async {
    final Uri $url = Uri.parse('/auth/register');
    final $body = registerDto;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> loginWithPhone(
    LoginPhoneDto loginPhoneDto,
  ) async {
    final Uri $url = Uri.parse('/auth/login-with-phone');
    final $body = loginPhoneDto;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> createOrUpdatePin(
    CreateUpdatePinDto createUpdatePinDto,
  ) async {
    final Uri $url = Uri.parse('/auth/create-pin');
    final $body = createUpdatePinDto;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> createRequiredPin(
    CreateUpdatePinDto createUpdatePinDto,
  ) async {
    final Uri $url = Uri.parse('/auth/create-required-pin');
    final $body = createUpdatePinDto;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> getBeneficiaries() async {
    final Uri $url = Uri.parse('/auth/beneficiaries');
    final Request $request = Request('GET', $url, client.baseUrl);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> addBeneficiary(
    AddBeneficiaryDto addBeneficiaryDto,
  ) async {
    final Uri $url = Uri.parse('/auth/add-beneficiaries');
    final $body = addBeneficiaryDto;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> getUserByPhoneNumber(String phoneNumber) async {
    final Uri $url = Uri.parse('/auth/get/${phoneNumber}');
    final Request $request = Request('GET', $url, client.baseUrl);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> getUserById(String userId) async {
    final Uri $url = Uri.parse('/auth/account');
    final Request $request = Request('GET', $url, client.baseUrl);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> changePassword(UpdatePasswordDto dto) async {
    final Uri $url = Uri.parse('/auth/change-password');
    final $body = dto;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> changeCodePin(SetPinDto dto) async {
    final Uri $url = Uri.parse('/auth/update-code');
    final $body = dto;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> resetPassword(ResetPasswordDto dto) async {
    final Uri $url = Uri.parse('/auth/reset');
    final $body = dto;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> resetPasswordEmail(
    ResetPasswordEmailDto dto,
  ) async {
    final Uri $url = Uri.parse('/auth/reset-by-email');
    final $body = dto;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> loginWithPin(LoginWithPinDto dto) async {
    final Uri $url = Uri.parse('/auth/login-with-pin');
    final $body = dto;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> addEmailToAccount(
    AddEmailToAccountDto dto,
  ) async {
    final Uri $url = Uri.parse('/auth/add-email');
    final $body = dto;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> loginWithEmail(LoginWithEmailDto dto) async {
    final Uri $url = Uri.parse('/auth/login-with-email');
    final $body = dto;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> resetPin(ResetCodePinDto dto) async {
    final Uri $url = Uri.parse('/auth/reset-pin');
    final $body = dto;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> logout() async {
    final Uri $url = Uri.parse('/auth/logout');
    final Request $request = Request('POST', $url, client.baseUrl);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> requestDeletion() async {
    final Uri $url = Uri.parse('/auth/request-deletion');
    final Request $request = Request('POST', $url, client.baseUrl);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<Map<String, dynamic>> cancelDeletion() async {
    final Uri $url = Uri.parse('/auth/cancel-deletion');
    final Request $request = Request('POST', $url, client.baseUrl);
    final Response $response = await client
        .send<Map<String, dynamic>, Map<String, dynamic>>($request);
    return $response.bodyOrThrow;
  }
}
