import "dart:async";
import 'package:chopper/chopper.dart';
part 'country.service.chopper.dart';

@ChopperApi(baseUrl: '/countries')
abstract class CountryService extends ChopperService {
  static CountryService create([ChopperClient? client]) =>
      _$CountryService(client);

  @GET(path: '/mobile-money/per-country')
  Future<List<dynamic>> getCountriesWithMobileMoney();
}
