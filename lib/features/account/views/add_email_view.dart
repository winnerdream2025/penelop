import 'package:corrispay/app/routes/routes_names.dart';
import 'package:corrispay/core/utils/functions.dart';
import 'package:corrispay/features/account/dto/send-email-otp.dto.dart';
import 'package:corrispay/features/auth/providers/otp_provider.dart';
import 'package:corrispay/features/bases/widgets/rounded_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../app/design/assets/assets_icons.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../../../l10n/app_localizations.dart';
import '../../bases/widgets/default_button.dart';
import '../../bases/widgets/default_field.dart';

class AddEmailView extends ConsumerStatefulWidget {
  const AddEmailView({super.key});

  @override
  ConsumerState<AddEmailView> createState() => _AddEmailViewState();
}

class _AddEmailViewState extends ConsumerState<AddEmailView> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  bool _isEmailValid(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }

  bool get _isValid => _isEmailValid(_emailController.text);
  bool get _showError =>
      _emailController.text.isNotEmpty && !_isEmailValid(_emailController.text);

  void submitForm() async {
    FocusScope.of(context).unfocus();
    showLoading();
    final response = await ref.read(
      sendEmailCodeProvider(
        SendEmailOtpDto(email: _emailController.text),
      ).future,
    );
    hideLoading();

    if (response != null && response.status) {
      Navigator.pushNamed(
        context,
        RoutesNames.verifyEmail,
        arguments: _emailController.text,
      );
    } else {
      showErrorMessage(response?.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

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
                  Icons.email_outlined,
                  color: Palette.petrolBlue,
                  size: 26,
                ),
              ),

              const Gap(14),
              Text(
                t.enter_your_email,
                style: FontsStyles.bold.copyWith(fontSize: 24),
              ),

              const Gap(6),

              Text(
                t.addEmailDescription,
                style: FontsStyles.regular.copyWith(
                  fontSize: 13,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),

              const Gap(28),
              DefaultField(
                controller: _emailController,
                label: t.email,
                hintText: t.email,
                prefixIconUrl: AssetsIcons.google,
                onChanged: (v) => setState(() {}),
              ),

              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: _showError
                    ? Padding(
                  key: const ValueKey('error'),
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.cancel_outlined,
                          size: 14, color: Colors.red),
                      const Gap(6),
                      Text(
                        t.enter_valid_email,
                        style: FontsStyles.regular.copyWith(
                          fontSize: 12,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                )
                    : _isValid
                    ? Padding(
                  key: const ValueKey('valid'),
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_outline,
                          size: 14, color: Colors.green),
                      const Gap(6),
                      Text(
                        t.validEmail,
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
      bottomSheet:  Container(
        color: Palette.white,
        padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
          bottom: 24
        ),
        child: DefaultButton(
          isEnable: _isValid,
          onTap: _isValid ? submitForm : null,
          bgColor: Palette.petrolBlue,
          text: t.next,
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