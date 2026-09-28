import 'package:corrispay/features/merchant/models/merchant-account-model.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:get_storage/get_storage.dart';
import '../../app/utils/localkeys.dart';

class MerchantAccountLocalNotifier
    extends StateNotifier<MerchantAccountModel?> {
  final GetStorage _box;

  MerchantAccountLocalNotifier(this._box) : super(null) {
    _load();
  }

  void _load() {
    final json = _box.read(LocalKeys.merchantAccount);
    if (json != null) {
      state = MerchantAccountModel.fromJson(Map<String, dynamic>.from(json));
    }
  }

  void saveMerchantAccount(MerchantAccountModel? merchantAccount) {
    state = merchantAccount;
    if (merchantAccount != null) {
      _box.write(LocalKeys.merchantAccount, merchantAccount.toJson());
    } else {
      _box.remove(LocalKeys.merchantAccount);
    }
  }

  void clearSettings() {
    state = null;
    _box.remove(LocalKeys.merchantAccount);
  }
}

final merchantAccountLocalProvider =
    StateNotifierProvider<MerchantAccountLocalNotifier, MerchantAccountModel?>((
      ref,
    ) {
      return MerchantAccountLocalNotifier(GetStorage());
    });
