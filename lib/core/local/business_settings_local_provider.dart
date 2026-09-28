import 'package:corrispay/features/auth/models/business_settings.model.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:get_storage/get_storage.dart';
import '../../app/utils/localkeys.dart';

class BusinessSettingsLocalNotifier extends StateNotifier<BusinessSettings?> {
  final GetStorage _box;

  BusinessSettingsLocalNotifier(this._box) : super(null) {
    _loadSettings();
  }

  void _loadSettings() {
    final json = _box.read(LocalKeys.businessSettings);
    if (json != null) {
      state = BusinessSettings.fromJson(Map<String, dynamic>.from(json));
    }
  }

  void saveSettings(BusinessSettings settings) {
    state = settings;
    _box.write(LocalKeys.businessSettings, settings.toJson());
    _box.write(
      LocalKeys.businessSettingsFetchedAt,
      DateTime.now().toIso8601String(),
    );
  }

  void clearSettings() {
    state = null;
    _box.remove(LocalKeys.businessSettings);
    _box.remove(LocalKeys.businessSettingsFetchedAt);
  }
}

final businessSettingsLocalProvider =
    StateNotifierProvider<BusinessSettingsLocalNotifier, BusinessSettings?>((
      ref,
    ) {
      return BusinessSettingsLocalNotifier(GetStorage());
    });
