import 'dart:async';
import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:corrispay/features/auth/providers/otp_provider.dart';
import 'package:corrispay/features/bases/widgets/default_button.dart';
import 'package:corrispay/features/bases/widgets/rounded_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import '../../../app/design/palette.dart';
import '../../../app/routes/routes_names.dart';
import '../../../core/utils/functions.dart';
import '../../../l10n/app_localizations.dart';
import '../dto/send-phone-otp.dto.dart';
import '../dto/verify_otp.dto.dart';

class ConfirmResetPinOtpView extends ConsumerStatefulWidget {
  const ConfirmResetPinOtpView({super.key, required this.phoneNumber});
  final String phoneNumber;

  @override
  ConsumerState<ConfirmResetPinOtpView> createState() =>
      _ConfirmResetPinOtpViewState();
}

class _ConfirmResetPinOtpViewState
    extends ConsumerState<ConfirmResetPinOtpView> {
  final otpCodeController = TextEditingController();

  static const int _countdownSeconds = 60;
  int _secondsLeft = _countdownSeconds;
  bool _canResend = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    otpCodeController.dispose();
    super.dispose();
  }

  void _startCountdown() {
    _secondsLeft = _countdownSeconds;
    _canResend = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      setState(() {
        if (_secondsLeft > 0) {
          _secondsLeft--;
        } else {
          _canResend = true;
          t.cancel();
        }
      });
    });
  }

  Future<void> submitForm() async {
    showLoading();
    final response = await ref.read(
      verifyCodeProvider(
        VerifyOtpDto(
          code: otpCodeController.text,
          identifier: widget.phoneNumber,
        ),
      ).future,
    );
    hideLoading();
    if (!mounted) return;

    if (response != null && response.status) {
      showSuccessMessage(response.message);
      Navigator.pushNamed(
        context,
        RoutesNames.resetPincode,
        arguments: (otpCodeController.text, widget.phoneNumber),
      );
    } else {
      showErrorMessage(response?.message);
    }
  }

  Future<void> resendCode() async {
    if (!_canResend) return;
    showLoading();
    final response = await ref.read(
      sendResetPasswordCodeProvider(
        SendPhoneOtpDto(phoneNumber: widget.phoneNumber),
      ).future,
    );
    hideLoading();
    if (!mounted) return;

    if (response != null && response.status) {
      otpCodeController.clear();
      _startCountdown();

    } else {
      showErrorMessage(response?.message);
    }
  }

  String get _countdownText {
    final minutes = _secondsLeft ~/ 60;
    final seconds = _secondsLeft % 60;
    if (minutes > 0) {
      return '${minutes}min ${seconds.toString().padLeft(2, '0')}s';
    }
    return '${seconds}s';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Palette.white,
     
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RoundedBackButton(),
              const Gap(12),
              Text(
                l10n.confirmOtpTitle,
                style: FontsStyles.bold.copyWith(
                  fontSize: 26,
                  color: Palette.black,
                ),
              ),
              const Gap(6),
              Text(
                l10n.confirmOtpDescription,
                style: FontsStyles.regular.copyWith(
                  fontSize: 13,
                  color: Colors.grey.shade500,
                ),
              ),
              const Gap(28),
        
        
              Center(
                child: Pinput(
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  controller: otpCodeController,
                  onChanged: (value) => setState(() {}),
                ),
              ),
        
              const Gap(24),
        
        
              Center(
                child: _canResend
                    ? GestureDetector(
                        onTap: resendCode,
                        child: RichText(
                          text: TextSpan(
                            style: FontsStyles.regular.copyWith(fontSize: 13),
                            children: [
                              TextSpan(
                                text: l10n.codeNotReceived,
                                style: TextStyle(color: Colors.grey.shade400),
                              ),
                              TextSpan(
                                text: l10n.resend,
                                style: FontsStyles.bold.copyWith(
                                  fontSize: 13,
                                  color: Palette.petrolBlue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : RichText(
                        text: TextSpan(
                          style: FontsStyles.regular.copyWith(fontSize: 13),
                          children: [
                            TextSpan(
                              text: "${l10n.resendIn} ",
                              style: TextStyle(color: Colors.grey.shade400),
                            ),
                            TextSpan(
                              text: _countdownText,
                              style: FontsStyles.bold.copyWith(
                                fontSize: 13,
                                color: Palette.petrolBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
        
              const Spacer(),
        
              DefaultButton(
                isEnable: otpCodeController.text.length == 6,
                onTap: submitForm,
                bgColor: Palette.petrolBlue,
                text: l10n.confirm,
                padding: 16,
                textStyle: FontsStyles.regular.copyWith(
                  fontSize: 16,
                  color: Palette.white,
                ),
              ),
              const Gap(32),
            ],
          ),
        ),
      ),
    );
  }
}
