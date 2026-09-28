import 'package:flutter_riverpod/legacy.dart';
import 'package:get_storage/get_storage.dart';
import '../../app/utils/localkeys.dart';

class OnboardingNotifier extends StateNotifier<bool> {
  final GetStorage _box;

  OnboardingNotifier(this._box) : super(false) {
    _load();
  }

  void _load() {
    state = _box.read(LocalKeys.hasSeenOnboarding) ?? false;
  }

  void markAsSeen() {
    state = true;
    _box.write(LocalKeys.hasSeenOnboarding, true);
  }

  void reset() {
    state = false;
    _box.remove(LocalKeys.hasSeenOnboarding);
  }
}

final onboardingProvider =
StateNotifierProvider<OnboardingNotifier, bool>((ref) {
  return OnboardingNotifier(GetStorage());
});
