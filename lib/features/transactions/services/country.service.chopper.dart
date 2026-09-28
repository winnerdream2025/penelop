// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'country.service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$CountryService extends CountryService {
  _$CountryService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = CountryService;

  @override
  Future<List<dynamic>> getCountriesWithMobileMoney() async {
    final Uri $url = Uri.parse('/countries/mobile-money/per-country');
    final Request $request = Request('GET', $url, client.baseUrl);
    final Response $response = await client.send<List<dynamic>, List<dynamic>>(
      $request,
    );
    return $response.bodyOrThrow;
  }
}
