import 'package:corrispay/core/utils/functions.dart';
import 'package:corrispay/features/mobiles-transactions/dto/confirm-withdrawal-mobile.dto.dart';
import 'package:corrispay/features/mobiles-transactions/providers/mobile-withdrawal.provider.dart';
import 'package:corrispay/features/mobiles-transactions/responses/mobile_withdrawal_preview_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/design/palette.dart';
import '../../../app/routes/routes_names.dart';
import '../../../l10n/app_localizations.dart';
import '../../bases/providers/security_provider.dart';
import '../../bases/views/pin_code_scaffold.dart';

class EnterWithdrawalCodeView extends ConsumerWidget {
  const EnterWithdrawalCodeView({super.key, required this.transaction});

  final MobileWithdrawalPreviewData transaction;

  Future<String?> _submit(
      WidgetRef ref,
      BuildContext context, {
        required String codePin,
        required bool biometric,
      }) async {
    showLoading();

    final response = await ref.read(
      confirmMobileWithdrawalProvider(
        ConfirmWithdrawalMobileDto(
          amount: transaction.amount,
          phoneNumber: transaction.phoneNumber,
          country: transaction.country,
          operator: transaction.operator,
          codePin: biometric ? null : codePin,
          biometricAuth: biometric,
        ),
      ).future,
    );

    hideLoading();

    if (response != null && response.status && response.data != null) {
      if (!context.mounted) return null;
      Navigator.pushNamed(
        context,
        RoutesNames.verificationCodeCompleted,
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
      subtitle: tr.confirm_identity_withdrawal,
      pinLength: 6,
      isFingerprintEnabled: isFingerPrintEnabled,
      onPinComplete: (pin) =>
          _submit(ref, context, codePin: pin, biometric: false),
      onFingerprintTap: () async {
        final authenticated =
        await ref.read(securityServiceProvider).authenticate();
        if (authenticated && context.mounted) {
          await _submit(ref, context, codePin: '', biometric: true);
        }
      },
      bottomActions: [
        PinCodeScaffoldAction(
          label: tr.forgot_pin_code,
          color: Palette.petrolBlue,
          onTap: () => Navigator.pushNamed(
            context,
            RoutesNames.forgotPincode,
            arguments: false,
          ),
        ),
      ],
    );
  }
}