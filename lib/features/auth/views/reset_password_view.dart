import 'package:corrispay/features/auth/dto/reset_password_dto.dart';
import 'package:corrispay/features/auth/dto/reset_password_email.dto.dart';
import 'package:corrispay/features/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/design/assets/assets_icons.dart';
import '../../../../app/design/fonts_styles.dart';
import '../../../../app/design/palette.dart';
import '../../../../app/routes/routes_names.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../core/utils/functions.dart';
import '../../bases/widgets/default_button.dart';
import '../../bases/widgets/default_field.dart';
import '../../bases/widgets/rounded_back_button.dart';

class ResetPasswordView extends ConsumerStatefulWidget {
  const ResetPasswordView({super.key, required this.data});
  final (int, String) data;

  @override
  ConsumerState<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends ConsumerState<ResetPasswordView> {
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _isPasswordObscur = true;
  bool _isConfirmObscur = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  bool _isFormValid() {
    return _passwordController.text.isNotEmpty &&
        _confirmController.text.isNotEmpty &&
        _passwordController.text == _confirmController.text;
  }

  bool get _passwordsMatch =>
      _confirmController.text.isNotEmpty &&
      _passwordController.text == _confirmController.text;

  bool get _passwordsMismatch =>
      _confirmController.text.isNotEmpty &&
      _passwordController.text != _confirmController.text;

  void submitForm() async {
    FocusScope.of(context).unfocus();
    showLoading();
    final response = widget.data.$1 == 0
        ? await ref.read(
            resetPasswordProvider(
              ResetPasswordDto(
                phoneNumber: widget.data.$2,
                newPassword: _passwordController.text,
              ),
            ).future,
          )
        : await ref.read(
            resetPasswordEmailProvider(
              ResetPasswordEmailDto(
                email: widget.data.$2,
                newPassword: _passwordController.text,
              ),
            ).future,
          );
    hideLoading();

    if (response != null && response.status) {
      showSuccessMessage(response.message);
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesNames.auth,
        (route) => false,
      );
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
              Gap(8),


              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: Palette.petrolBlue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lock_reset_rounded,
                  color: Palette.petrolBlue,
                  size: 26,
                ),
              ),

              const Gap(8),


              Text(
                l10n.resetPasswordTitle,
                style: FontsStyles.bold.copyWith(fontSize: 24),
              ),


              Text(
                l10n.resetPasswordDescription,
                textAlign: TextAlign.center,
                style: FontsStyles.regular.copyWith(
                  fontSize: 13,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),

              const Gap(8),


              DefaultField(
                controller: _passwordController,
                label: l10n.password,
                prefixIconUrl: AssetsIcons.phone,
                suffixIconUrl: _isPasswordObscur
                    ? AssetsIcons.eyeOff
                    : AssetsIcons.eyeOn,
                isObscur: _isPasswordObscur,
                onChanged: (v) => setState(() {}),
                changeObscur: () =>
                    setState(() => _isPasswordObscur = !_isPasswordObscur),
                hintText: l10n.password,
              ),


              DefaultField(
                controller: _confirmController,
                label: l10n.confirmPassword,
                hintText: l10n.confirmPassword,
                prefixIconUrl: AssetsIcons.phone,
                suffixIconUrl: _isConfirmObscur
                    ? AssetsIcons.eyeOff
                    : AssetsIcons.eyeOn,
                isObscur: _isConfirmObscur,
                onChanged: (v) => setState(() {}),
                changeObscur: () =>
                    setState(() => _isConfirmObscur = !_isConfirmObscur),
              ),


              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: _passwordsMismatch
                    ? Padding(
                        key: const ValueKey('mismatch'),
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.cancel_outlined,
                              size: 14,
                              color: Colors.red,
                            ),
                            const Gap(6),
                            Text(
                              l10n.passwordMismatch,
                              style: FontsStyles.regular.copyWith(
                                fontSize: 12,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      )
                    : _passwordsMatch
                    ? Padding(
                        key: const ValueKey('match'),
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.check_circle_outline,
                              size: 14,
                              color: Colors.green,
                            ),
                            const Gap(6),
                            Text(
                              l10n.passwordMatch,
                              style: FontsStyles.regular.copyWith(
                                fontSize: 12,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(key: ValueKey('empty')),
              ),




            ],
          ),
        ),

      ),
      bottomSheet:
      Container(
        color: Palette.white,
        padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
          bottom: 24
        ),
        child: DefaultButton(
          isEnable: _isFormValid(),
          onTap: submitForm,
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
