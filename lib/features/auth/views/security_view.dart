import 'package:corrispay/app/routes/routes_names.dart';
import 'package:corrispay/features/auth/dto/register.dto.dart';
import 'package:corrispay/features/auth/providers/auth_provider.dart';
import 'package:corrispay/features/bases/widgets/rounded_back_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/design/assets/assets_icons.dart';
import '../../../../app/design/fonts_styles.dart';
import '../../../../app/design/palette.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../core/utils/functions.dart';
import '../../bases/widgets/default_button.dart';
import '../../bases/widgets/default_field.dart';

class SecurityView extends ConsumerStatefulWidget {
  const SecurityView({super.key, required this.registerDto});
  final RegisterDto registerDto;

  @override
  ConsumerState<SecurityView> createState() => _SecurityViewState();
}

class _SecurityViewState extends ConsumerState<SecurityView> {
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
    final fcmToken = await ref.read(fcmTokenProvider.future);

    showLoading();
    final response = await ref.read(
      registerProvider(
        widget.registerDto.copyWith(
          password: _passwordController.text,
          fcmToken: fcmToken,
        ),
      ).future,
    );
    hideLoading();

    if (response != null && response.status && response.data != null) {
      showSuccessMessage(response.message);
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesNames.createCodePin,
            (route) => false,
        arguments: response.data!.dashboardData,
      );
    } else {
      showErrorMessage(response?.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Palette.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            RoundedBackButton(),

              const Gap(8),


              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: Palette.petrolBlue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.shield_outlined,
                  color: Palette.petrolBlue,
                  size: 26,
                ),
              ),

              const Gap(4),


              Text(
                loc.securityTitle,
                style: FontsStyles.bold.copyWith(fontSize: 24),
              ),


              Text(
                loc.securityDescription,
                style: FontsStyles.regular.copyWith(
                  fontSize: 13,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),

              const Gap(16),


              DefaultField(
                prefixIconUrl: AssetsIcons.phone,
                controller: _passwordController,
                label: loc.password,
                hintText: loc.password,
                suffixIconUrl:
                _isPasswordObscur ? AssetsIcons.eyeOff : AssetsIcons.eyeOn,
                isObscur: _isPasswordObscur,
                onChanged: (v) => setState(() {}),
                changeObscur: () =>
                    setState(() => _isPasswordObscur = !_isPasswordObscur),
              ),


              DefaultField(
                controller: _confirmController,
                label: loc.confirmPassword,
                hintText: loc.confirmPassword,
                prefixIconUrl: AssetsIcons.phone,
                suffixIconUrl:
                _isConfirmObscur ? AssetsIcons.eyeOff : AssetsIcons.eyeOn,
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
                      const Icon(Icons.cancel_outlined,
                          size: 14, color: Colors.red),
                      const Gap(6),
                      Text(
                        loc.passwordMismatch,
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
                      const Icon(Icons.check_circle_outline,
                          size: 14, color: Colors.green),
                      const Gap(6),
                      Text(
                        loc.passwordMatch,
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





              const Gap(24),
            ],
          ),
        ),
      ),
      bottomSheet:
      Container(
        color: Palette.white,
        padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
          bottom: 24,
        ),
        child: DefaultButton(
          isEnable: _isFormValid(),
          onTap: _isFormValid() ? submitForm : null,
          bgColor: Palette.petrolBlue,
          text: loc.confirm,
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