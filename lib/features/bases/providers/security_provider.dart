import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';

class SecurityService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> authenticate() async {
    try {
      final canAuthenticateWithBiometrics =
      await _auth.canCheckBiometrics;
      final canAuthenticate =
          canAuthenticateWithBiometrics ||
              await _auth.isDeviceSupported();

      if (!canAuthenticate) return false;

      final didAuthenticate = await _auth.authenticate(
        localizedReason: 'Please authenticate to show account balance',
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: 'Oops! Biometric authentication required!',
            cancelButton: 'No thanks',
          ),
          IOSAuthMessages(cancelButton: 'No thanks'),
        ],
      );

      return didAuthenticate;
    } catch (e) {

      return false;
    }
  }
}


final securityServiceProvider = Provider<SecurityService>(
      (ref) => SecurityService(),
);



final fingerprintEnabledProvider =
StateNotifierProvider<FingerprintNotifier, bool>(
      (ref) => FingerprintNotifier(),
);

class FingerprintNotifier extends StateNotifier<bool> {
  static const String _fingerPrintKey = 'fingerprint_enabled';
  final GetStorage _box = GetStorage();

  FingerprintNotifier() : super(false) {
    state = _box.read<bool>(_fingerPrintKey) ?? false;
  }

  void setFingerPrint(bool value) {
    state = value;
    _box.write(_fingerPrintKey, value);
  }
}
