import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/app_info.dart';
import '../repositories/app_repository.dart';

final getAppInfoProvider = FutureProvider.family<AppInfo?, String>((
    ref,
    platform,
    ) async {
  final appRepository = ref.watch(appRepositoryProvider);
  final response = await appRepository.getAppConfig(platform);

  print(response);
  return response;
});