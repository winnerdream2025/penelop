import 'dart:async';
import 'package:corrispay/core/utils/functions.dart';
import 'package:corrispay/features/bases/widgets/rounded_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../../../l10n/app_localizations.dart';
import '../dto/add_email_to_account.dto.dart';
import '../../auth/providers/auth_provider.dart';
import '../../auth/providers/otp_provider.dart';
import '../dto/send-email-otp.dto.dart';
import '../../bases/widgets/default_button.dart';

class VerifyEmailView extends ConsumerStatefulWidget {
  const VerifyEmailView({super.key, required this.email});
  final String email;

  @override
  ConsumerState<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends ConsumerState<VerifyEmailView> {
  final otpCodeController = TextEditingController();

  static const int _countdownSeconds = 60;
  int _secondsRemaining = _countdownSeconds;
  Timer? _timer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    otpCodeController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _secondsRemaining = _countdownSeconds;
      _canResend = false;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining <= 1) {
        timer.cancel();
        setState(() {
          _secondsRemaining = 0;
          _canResend = true;
        });
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  void _resendCode() async {
    if (!_canResend) return;
    showLoading();
    final response = await ref.read(
      sendEmailCodeProvider(
        SendEmailOtpDto(email: widget.email),
      ).future,
    );
    hideLoading();

    if (response != null && response.status) {
      otpCodeController.clear();
      _startTimer();
     // showSuccessMessage(response.message);
    } else {
      showErrorMessage(response?.message);
    }
  }

  void submitForm() async {
    showLoading();
    final response = await ref.read(
      addEmailProvider(
        AddEmailToAccountDto(
          email: widget.email,
          otp: otpCodeController.text,
        ),
      ).future,
    );
    hideLoading();

    if (!mounted) return;

    if (response != null && response.status) {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      showSuccessMessage(response.message);
    } else {
      showErrorMessage(response?.message);
    }
  }

  String get _formattedTime {
    final minutes = _secondsRemaining ~/ 60;
    final seconds = _secondsRemaining % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Palette.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             RoundedBackButton(),

              const Gap(24),


              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: Palette.petrolBlue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.mark_email_unread_outlined,
                  color: Palette.petrolBlue,
                  size: 26,
                ),
              ),

              const Gap(14),


              Text(
                l10n.email_verification,
                style: FontsStyles.bold.copyWith(fontSize: 24),
              ),

              const Gap(6),


              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: l10n.email_verification_code_sent,
                      style: FontsStyles.regular.copyWith(
                        fontSize: 13,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),
                    TextSpan(
                      text: " ${widget.email}",
                      style: FontsStyles.bold.copyWith(
                        fontSize: 13,
                        color: Palette.petrolBlue,
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

              const Gap(24),


              Center(
                child: _canResend
                    ? GestureDetector(
                  onTap: _resendCode,
                  child: Text(
                    l10n.resend_code,
                    style: FontsStyles.bold.copyWith(
                      fontSize: 13,
                      color: Palette.petrolBlue,
                      decoration: TextDecoration.underline,
                      decorationColor: Palette.petrolBlue,
                      decorationThickness: 1.2,
                    ),
                  ),
                )
                    : RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${l10n.resendCodeIn} ",
                        style: FontsStyles.regular.copyWith(
                          fontSize: 13,
                          color: Colors.black45,
                        ),
                      ),
                      TextSpan(
                        text: _formattedTime,
                        style: FontsStyles.bold.copyWith(
                          fontSize: 13,
                          color: Palette.petrolBlue,
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
          onTap:
          otpCodeController.text.length == 6 ? submitForm : null,
          bgColor: Palette.petrolBlue,
          text: l10n.confirm,
          padding: 16,
          textStyle: FontsStyles.regular.copyWith(
            fontSize: 16,
            color: Palette.white,
          ),
        ),
      ),
    );
  }
}