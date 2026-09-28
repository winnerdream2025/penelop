import 'package:corrispay/features/bases/providers/security_provider.dart';
import 'package:corrispay/features/bases/views/pin_code_scaffold.dart';
import 'package:corrispay/features/transactions/dto/confirm_intern_transaction.dto.dart';
import 'package:corrispay/features/transactions/models/intern_transaction.dart';
import 'package:corrispay/features/transactions/providers/transactions_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/design/palette.dart';
import '../../../app/routes/routes_names.dart';
import '../../../core/utils/functions.dart';
import '../../../l10n/app_localizations.dart';

class EnterCodeView extends ConsumerWidget {
  const EnterCodeView({super.key, required this.transaction});
  final InternTransaction transaction;

  Future<String?> _submit(
    WidgetRef ref,
    BuildContext context, {
    required String codePin,
    required bool biometric,
  }) async {
    showLoading();

    final response = await ref.read(
      confirmInternTransactionProvider(
        ConfirmInternTransactionDto(
          to: transaction.to,
          amount: transaction.originalAmount.toString(),
          codePin: codePin,
          biometricAuth: biometric,
        ),
      ).future,
    );

    hideLoading();

    if (response != null && response.status && response.data != null) {
      if (!context.mounted) return null;
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesNames.verificationCodeCompleted,
        (route) => false,
        arguments: response.data,
      );
      return null;
    }

    if (context.mounted) Navigator.pop(context);
    showErrorMessage(response?.message);
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
