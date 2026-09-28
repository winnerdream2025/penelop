import 'dart:async';
import 'package:corrispay/features/bases/widgets/rounded_back_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/design/fonts_styles.dart';
import '../../../../app/design/palette.dart';
import '../../../../app/routes/routes_names.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../core/utils/functions.dart';
import '../../account/dto/send-email-otp.dto.dart';
import '../../bases/widgets/default_button.dart';
import '../dto/send-phone-otp.dto.dart';
import '../dto/verify_otp.dto.dart';
import '../providers/otp_provider.dart';

class ConfirmOtpPasswordView extends ConsumerStatefulWidget {
  const ConfirmOtpPasswordView({super.key, required this.data});
  final (int, String) data;

  @override
  ConsumerState<ConfirmOtpPasswordView> createState() =>
      _ConfirmOtpPasswordViewState();
}

class _ConfirmOtpPasswordViewState
    extends ConsumerState<ConfirmOtpPasswordView> {
  final otpCodeController = TextEditingController();

  bool get _isPhone => widget.data.$1 == 0;

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
    setState(() { _secondsLeft = _countdownSeconds; _canResend = false; });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) { t.cancel(); return; }
      setState(() {
        if (_secondsLeft > 0) { _secondsLeft--; }
        else { _canResend = true; t.cancel(); }
      });
    });
  }

  String get _formattedTime {
    final m = _secondsLeft ~/ 60;
    final s = _secondsLeft % 60;
    return m > 0 ? '${m}min ${s.toString().padLeft(2, '0')}s' : '${s.toString().padLeft(2, '0')}s';
  }

  Future<void> submitForm() async {
    showLoading();
    final response = await ref.read(
      verifyCodeProvider(
        VerifyOtpDto(code: otpCodeController.text, identifier: widget.data.$2),
      ).future,
    );
    hideLoading();
    if (!mounted) return;

    if (response != null && response.status) {
      showSuccessMessage(response.message);
      Navigator.pushNamed(context, RoutesNames.resetPassword, arguments: widget.data);
    } else {
      showErrorMessage(response?.message);
    }
  }

  Future<void> resendCode() async {
    if (!_canResend) return;
    showLoading();
    final response = _isPhone
        ? await ref.read(sendResetPasswordCodeProvider(SendPhoneOtpDto(phoneNumber: widget.data.$2)).future)
        : await ref.read(sendEmailResetPasswordCodeProvider(SendEmailOtpDto(email: widget.data.$2)).future);
    hideLoading();
    if (!mounted) return;

    if (response != null && response.status) {
      otpCodeController.clear();
      _startCountdown();
     // showSuccessMessage(response.message);
    } else {
      showErrorMessage(response?.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Palette.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             RoundedBackButton(),
              const Gap(16),


              Container(
                width: 52, height: 52,
                decoration: BoxDecoration(
                  color: Palette.petrolBlue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _isPhone ? Icons.sms_outlined : Icons.mark_email_unread_outlined,
                  color: Palette.petrolBlue,
                  size: 26,
                ),
              ),

              const Gap(8),


              Text(
                _isPhone ? l10n.confirmOtpTitle : l10n.confirmEmailTitle,
                style: FontsStyles.bold.copyWith(fontSize: 24, color: Palette.black),
              ),


              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: l10n.confirmOtpDescription,
                      style: FontsStyles.regular.copyWith(
                        fontSize: 13, color: Colors.black54, height: 1.5,
                      ),
                    ),
                    TextSpan(
                      text: " ${widget.data.$2}",
                      style: FontsStyles.bold.copyWith(
                        fontSize: 13, color: Palette.petrolBlue,
                      ),
                    ),
                  ],
                ),
              ),

              const Gap(32),


              Center(
                child: Pinput(
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  controller: otpCodeController,
                  onChanged: (value) => setState(() {}),
                  onCompleted: (_) => submitForm(),
                ),
              ),

              const Gap(20),


              Center(
                child: _canResend
                    ? GestureDetector(
                  onTap: resendCode,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: l10n.codeNotReceived,
                          style: FontsStyles.regular.copyWith(
                            fontSize: 13, color: Colors.grey.shade400,
                          ),
                        ),
                        TextSpan(
                          text: l10n.resend,
                          style: FontsStyles.bold.copyWith(
                            fontSize: 13,
                            color: Palette.petrolBlue,
                            decoration: TextDecoration.underline,
                            decorationColor: Palette.petrolBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                    : RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: l10n.resendIn,
                        style: FontsStyles.regular.copyWith(
                          fontSize: 13, color: Colors.grey.shade400,
                        ),
                      ),
                      TextSpan(
                        text: _formattedTime,
                        style: FontsStyles.bold.copyWith(
                          fontSize: 13, color: Palette.petrolBlue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
      bottomSheet:  Container(
        color: Palette.white,
        padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
          bottom: 24
        ),
        child: DefaultButton(
          isEnable: otpCodeController.text.length == 6,
          onTap: otpCodeController.text.length == 6 ? submitForm : null,
          bgColor: Palette.petrolBlue,
          text: l10n.confirm,
          padding: 16,
          textStyle: FontsStyles.regular.copyWith(
            fontSize: 16, color: Palette.white,
          ),
        ),
      ),
    );
  }
}