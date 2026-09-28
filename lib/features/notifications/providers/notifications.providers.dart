import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/notifications.dart';
import '../repositories/notifications.repository.dart';

final getNotificationsProvider = FutureProvider<NotificationsResponse?>((
  ref,
) async {
  final repository = ref.watch(notificationRepositoryProvider);
  return repository.getNotifications();
});
