import 'dart:async';
import 'package:corrispay/core/utils/functions.dart';
import 'package:corrispay/features/bases/providers/security_provider.dart';
import 'package:corrispay/features/bases/views/pin_code_scaffold.dart';
import 'package:corrispay/features/requests/models/user-request.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/design/palette.dart';
import '../../../app/routes/routes_names.dart';
import '../../../l10n/app_localizations.dart';
import '../providers/user-request.provider.dart';

class ConfirmRequestView extends ConsumerStatefulWidget {
  const ConfirmRequestView({super.key, required this.request});
  final UserRequest request;

  @override
  ConsumerState<ConfirmRequestView> createState() => _ConfirmRequestViewState();
}

class _ConfirmRequestViewState extends ConsumerState<ConfirmRequestView> {
  Timer? _expirationWatcher;
  bool _alreadyHandledExpiration = false;

  @override
  void initState() {
    super.initState();
    _expirationWatcher = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!_alreadyHandledExpiration &&
          DateTime.now().isAfter(widget.request.expiresAt)) {
        _alreadyHandledExpiration = true;
        _handleExpired();
      }
    });
  }

  @override
  void dispose() {
    _expirationWatcher?.cancel();
    super.dispose();
  }

  void _handleExpired() {
    if (!mounted) return;
    final tr = AppLocalizations.of(context)!;

    ref
        .read(userRequestsNotifierProvider.notifier)
        .removeRequest(widget.request.id);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text(tr.request_expired_title),
        content: Text(tr.request_expired_message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(tr.ok),
          ),
        ],
      ),
    );
  }

  Future<String?> _submit(
    WidgetRef ref,
    BuildContext context, {
    required String codePin,
    required bool biometric,
  }) async {
    final tr = AppLocalizations.of(context)!;

    if (DateTime.now().isAfter(widget.request.expiresAt)) {
      return tr.request_expired_message;
    }
    showLoading();

    final response = await ref
        .read(userRequestsNotifierProvider.notifier)
        .confirmRequest(widget.request.id, codePin);

    hideLoading();
    if (response != null && response.status) {
     // Navigator.pop(context);
      showSuccessMessage(response.message);
    } else {
      showErrorMessage(response?.message);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    final isFingerPrintEnabled = ref.watch(fingerprintEnabledProvider);

    return PinCodeScaffold(
      leadingIcon: Icons.lock_outline_rounded,
      onClose: () => Navigator.pop(context),
      title: tr.enterPinCode,
      subtitle: tr.confirm_identity_transaction,
      pinLength: 6,
      isFingerprintEnabled: isFingerPrintEnabled,
      onPinComplete: (pin) =>
          _submit(ref, context, codePin: pin, biometric: false),
      onFingerprintTap: () async {
        final authenticated = await ref
            .read(securityServiceProvider)
            .authenticate();
        if (authenticated && context.mounted) {
          await _submit(ref, context, codePin: '', biometric: true);
        }
      },
      bottomActions: [
        PinCodeScaffoldAction(
          label: tr.forgot_pin,
          color: Palette.petrolBlue,
          onTap: () => Navigator.pushNamed(context, RoutesNames.forgotPincode),
        ),
      ],
    );
  }
}
