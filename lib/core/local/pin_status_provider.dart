import 'package:flutter_riverpod/legacy.dart';
import 'package:get_storage/get_storage.dart';

import '../../app/utils/localkeys.dart';

class PinStatusNotifier extends StateNotifier<bool> {
  final GetStorage _box;

  PinStatusNotifier(this._box) : super(false) {
    _load();
  }

  void _load() {
    state = _box.read(LocalKeys.hasCreatedPin) ?? false;
  }

  void markPinCreated() {
    state = true;
    _box.write(LocalKeys.hasCreatedPin, true);
  }

  void reset() {
    state = false;
    _box.remove(LocalKeys.hasCreatedPin);
  }
}

final pinStatusProvider =
StateNotifierProvider<PinStatusNotifier, bool>((ref) {
  return PinStatusNotifier(GetStorage());
});
