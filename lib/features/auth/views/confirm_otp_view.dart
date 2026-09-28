import 'dart:async';
import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:corrispay/app/design/palette.dart';
import 'package:corrispay/app/routes/routes_names.dart';
import 'package:corrispay/features/auth/dto/register.dto.dart';
import 'package:corrispay/features/auth/dto/send-phone-otp.dto.dart';
import 'package:corrispay/features/auth/dto/verify_otp.dto.dart';
import 'package:corrispay/features/auth/providers/otp_provider.dart';
import 'package:corrispay/features/bases/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../core/utils/functions.dart';
import '../../bases/widgets/rounded_back_button.dart';

class ConfirmOtpView extends ConsumerStatefulWidget {
  const ConfirmOtpView({super.key, required this.registerDto});
  final RegisterDto registerDto;

  @override
  ConsumerState<ConfirmOtpView> createState() => _ConfirmOtpViewState();
}

class _ConfirmOtpViewState extends ConsumerState<ConfirmOtpView> {
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
    setState(() {
      _secondsLeft = _countdownSeconds;
      _canResend = false;
    });
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

  String get _formattedTime {
    final m = _secondsLeft ~/ 60;
    final s = _secondsLeft % 60;
    return m > 0
        ? '${m}min ${s.toString().padLeft(2, '0')}s'
        : '${s.toString().padLeft(2, '0')}s';
  }

  Future<void> submitForm() async {
    showLoading();
    final response = await ref.read(
      verifyCodeProvider(
        VerifyOtpDto(
          code: otpCodeController.text,
          identifier: widget.registerDto.phoneNumber.toString(),
        ),
      ).future,
    );
    hideLoading();
    if (!mounted) return;

    if (response != null && response.status) {
      showSuccessMessage(response.message);
      Navigator.pushNamed(
        context,
        RoutesNames.info,
        arguments: widget.registerDto,
      );
    } else {
      showErrorMessage(response?.message);
    }
  }

  Future<void> resendCode() async {
    if (!_canResend) return;
    showLoading();
    final response = await ref.read(
      sendCodeProvider(
        SendPhoneOtpDto(phoneNumber: widget.registerDto.phoneNumber.toString()),
      ).future,
    );
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

              const Gap(24),


              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: Palette.petrolBlue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.sms_outlined,
                  color: Palette.petrolBlue,
                  size: 26,
                ),
              ),

              const Gap(14),


              Text(
                l10n.confirmOtpTitle,
                style: FontsStyles.bold.copyWith(
                  fontSize: 24,
                  color: Palette.black,
                ),
              ),

              const Gap(4),


              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: l10n.confirmOtpDescription,
                      style: FontsStyles.regular.copyWith(
                        fontSize: 13,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),
                    TextSpan(
                      text: " ${widget.registerDto.phoneNumber}",
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
                            fontSize: 13,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        TextSpan(
                          text: l10n.resend,
                          style: FontsStyles.bold.copyWith(
                            fontSize: 13,
                            color: Palette.petrolBlue,
                            decoration: TextDecoration.underline,
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
                          fontSize: 13,
                          color: Colors.grey.shade400,
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
      bottomSheet: Container(
        color: Palette.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ).copyWith(bottom: 24),
        child: DefaultButton(
          isEnable: otpCodeController.text.length == 6,
          onTap: otpCodeController.text.length == 6 ? submitForm : null,
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
