import "dart:async";
import 'package:chopper/chopper.dart';
part 'notifications.service.chopper.dart';

@ChopperApi(baseUrl: '/notifications')
abstract class NotificationsService extends ChopperService {
  static  NotificationsService create([ChopperClient? client]) =>
      _$NotificationsService(client);


  @GET(path: '/')
  Future<Map<String, dynamic>> getNotifications();



}
