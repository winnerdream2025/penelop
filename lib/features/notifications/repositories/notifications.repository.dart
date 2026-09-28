import 'package:corrispay/features/notifications/services/notifications.service.dart';
import 'package:riverpod/riverpod.dart';
import '../../../core/network/network_module.dart';
import '../models/notifications.dart';

class NotificationRepository {
  final NotificationsService notificationService;

  NotificationRepository(this.notificationService);

  Future<NotificationsResponse?> getNotifications() async {
    try {
      final response = await notificationService.getNotifications();
      print(response);
      return NotificationsResponse.fromJson(response);
    } catch (e) {
      print('getNotifications error: $e');
      return null;
    }
  }
}

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  final notificationService = chopperClient.getService<NotificationsService>();
  return NotificationRepository(notificationService);
});
