import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';

import '../repositories/devices_contacts_repository.dart';

final deviceContactsRepositoryProvider = Provider<DeviceContactsRepository>((
  ref,
) {
  return DeviceContactsRepository(GetStorage());
});
