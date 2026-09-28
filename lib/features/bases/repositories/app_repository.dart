import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/network/network_module.dart';
import '../services/app_info.service.dart';
import '../models/app_info.dart';

class AppRepository {
  final AppConfigService appConfigService;
  final _box = GetStorage();
  static const _cacheKey = 'app_config_cache';

  AppRepository(this.appConfigService);

  Future<AppInfo?> getAppConfig(String platform) async {
    // 1. Vérifie le cache GetStorage
    final cached = _getCached();
    if (cached != null && cached.isCacheValid) {
      print('✅ AppConfig depuis le cache');
      return cached;
    }

    // 2. Appel réseau
    try {
      print('🌐 AppConfig fetch API');
      final response = await appConfigService.getPlatformInfo(platform);
      print(response);
      final info = AppInfo.fromJson(response);
         print(info);
      // 3. Sauvegarde en cache avec timestamp
      _saveCache(info);
      print("cool");

      return info;
    } catch (e) {
      print('Erreur fetch AppConfig: $e');

      // 4. Fallback : cache expiré plutôt que null
      if (cached != null) {
        print('⚠️ Cache expiré utilisé en fallback');
        return cached;
      }
      return null;
    }
  }

  AppInfo? _getCached() {
    try {
      final raw = _box.read(_cacheKey); // ⚠️ plus de <Map<String, dynamic>> ici
      if (raw == null) return null;

      // Conversion explicite — gère le cas où raw revient en
      // Map<dynamic, dynamic> après un vrai redémarrage.
      final map = Map<String, dynamic>.from(raw as Map);
      return AppInfo.fromJson(map);
    } catch (e) {
      print('Erreur lecture cache: $e');
      return null;
    }
  }

  void _saveCache(AppInfo info) {
    try {
      final withTimestamp = info.copyWithCachedAt(DateTime.now());
      _box.write(_cacheKey, withTimestamp.toJson());
    } catch (e) {
      print('Erreur save cache: $e');
    }
  }

  void clearCache() {
    _box.remove(_cacheKey);
  }
}

final appRepositoryProvider = Provider<AppRepository>((ref) {
  final appService = chopperClient.getService<AppConfigService>();
  return AppRepository(appService);
});