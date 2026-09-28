import "dart:async";
import 'package:chopper/chopper.dart';
part 'app_info.service.chopper.dart';

@ChopperApi(baseUrl: '/app-config')
abstract class AppConfigService extends ChopperService {
  static AppConfigService create([ChopperClient? client]) =>
      _$AppConfigService(client);

  @GET(path: '/{platform}')
  Future<Map<String, dynamic>> getPlatformInfo(
    @Path('platform') String platform,
  );
}
