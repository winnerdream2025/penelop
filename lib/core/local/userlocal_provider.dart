import 'package:flutter_riverpod/legacy.dart';
import 'package:get_storage/get_storage.dart';

import '../../app/utils/localkeys.dart';
import '../../features/auth/models/user.model.dart';

class UserLocalNotifier extends StateNotifier<User?> {
  final GetStorage _box;

  UserLocalNotifier(this._box) : super(null) {
    _loadUser();
  }

  void _loadUser() {
    final json = _box.read(LocalKeys.user);
    if (json != null) {
      state = User.fromJson(Map<String, dynamic>.from(json));
    }
  }

  void saveUser(User user) {
    state = user;
    _box.write(LocalKeys.user, user.toJson());
    _box.write(LocalKeys.token, user.token);
  }

  void addEmail(String email) {
    final json = _box.read(LocalKeys.user);
    if (json != null) {
      User currentUser = User.fromJson(Map<String, dynamic>.from(json));

      User updatedUser = currentUser.copyWith(newEmail: email);

      state = updatedUser;
      _box.write(LocalKeys.user, updatedUser.toJson());
    }
  }

  void addMerchantAccount() {
    final json = _box.read(LocalKeys.user);
    if (json != null) {
      User currentUser = User.fromJson(Map<String, dynamic>.from(json));

      User updatedUser = currentUser.copyWith(hasMerchantAccount: true);

      state = updatedUser;
      _box.write(LocalKeys.user, updatedUser.toJson());
    }
  }

  void updateCodePin(bool hasCodePin) {
    final json = _box.read(LocalKeys.user);
    if (json != null) {
      User currentUser = User.fromJson(Map<String, dynamic>.from(json));

      User updatedUser = currentUser.copyWith(hasCodePin: hasCodePin);

      state = updatedUser;
      _box.write(LocalKeys.user, updatedUser.toJson());
    }
  }

  void updateUser(User user) {
    state = user;
    _box.write(LocalKeys.user, user.toJson());
  }

  Future<void> clearUser() async {
    state = null;
    _box.read(LocalKeys.hasSeenOnboarding);
    await _box.erase();

    _box.write(LocalKeys.hasSeenOnboarding, true);
  }

  void setDeletionStatus(String deletionRequestedAt, String deletionScheduledFor) {
    final json = _box.read(LocalKeys.user);
    if (json != null) {
      final data = Map<String, dynamic>.from(json as Map);
      data['deletionRequestedAt'] = deletionRequestedAt;
      data['deletionScheduledFor'] = deletionScheduledFor;
      final updatedUser = User.fromJson(data);
      state = updatedUser;
      _box.write(LocalKeys.user, updatedUser.toJson());
    }
  }

  void clearDeletionStatus() {
    final json = _box.read(LocalKeys.user);
    if (json != null) {
      final data = Map<String, dynamic>.from(json as Map);
      data.remove('deletionRequestedAt');
      data.remove('deletionScheduledFor');
      final updatedUser = User.fromJson(data);
      state = updatedUser;
      _box.write(LocalKeys.user, updatedUser.toJson());
    }
  }

  bool get isLoggedIn => state != null;
}

final userLocalProvider = StateNotifierProvider<UserLocalNotifier, User?>((
  ref,
) {
  return UserLocalNotifier(GetStorage());
});

class UserUtils {
  static String? getToken() {
    final box = GetStorage();
    return box.read(LocalKeys.token);
  }
}
