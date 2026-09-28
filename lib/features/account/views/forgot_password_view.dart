import 'package:corrispay/features/auth/providers/otp_provider.dart';
import 'package:corrispay/features/bases/widgets/rounded_back_button.dart';
import 'package:corrispay/features/transactions/models/country_operator_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/design/assets/assets_icons.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../../../app/routes/routes_names.dart';
import '../../../core/utils/functions.dart';
import '../../../l10n/app_localizations.dart';
import '../../bases/widgets/default_country_field.dart';
import '../dto/send-email-otp.dto.dart';
import '../../auth/dto/send-phone-otp.dto.dart';
import '../../bases/providers/country_provider.dart';
import '../../bases/widgets/default_button.dart';
import '../../bases/widgets/default_field.dart';
import '../../bases/widgets/default_phone_field.dart';

class ForgotPasswordView extends ConsumerStatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  ConsumerState<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends ConsumerState<ForgotPasswordView> {
  int index = 0;
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isPhoneNumberValid = false;
  late CountryOperatorModel selectedCountry;

  @override
  void initState() {
    super.initState();
    final countryCode = ref.read(countryProvider);

    selectedCountry = countryCode != null
        ? countries.firstWhere(
          (e) => e.countryCode == countryCode,
      orElse: () => countries.first,
    )
        : countries.first;

    phoneController.addListener(() {
      setState(() {
        isPhoneNumberValid =
            phoneController.text.length == selectedCountry.phoneLength;
      });
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  bool _isFormValid() {
    return index == 0
        ? phoneController.text.length == selectedCountry.phoneLength
        : emailController.text.isNotEmpty;
  }

  void submitForm() async {
    FocusScope.of(context).unfocus();
    showLoading();

    final response = index == 0
        ? await ref.read(
      sendResetPasswordCodeProvider(
        SendPhoneOtpDto(
          phoneNumber: selectedCountry.dialCode + phoneController.text,
        ),
      ).future,
    )
        : await ref.read(
      sendEmailResetPasswordCodeProvider(
        SendEmailOtpDto(email: emailController.text),
      ).future,
    );

    hideLoading();

    if (response != null && response.status) {
      Navigator.pushNamed(
        context,
        RoutesNames.confirmOtpPassword,
        arguments: (
        index,
        index == 0
            ? selectedCountry.dialCode + phoneController.text
            : emailController.text,
        ),
      );

    } else {
      showErrorMessage(response?.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isPhone = index == 0;

    return Scaffold(
      backgroundColor: Palette.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             RoundedBackButton(),
              const Gap(16),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: Container(
                  key: ValueKey(index),
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Palette.petrolBlue.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isPhone ? Icons.phone_outlined : Icons.email_outlined,
                    color: Palette.petrolBlue,
                    size: 26,
                  ),
                ),
              ),

              const Gap(8),


              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    key: ValueKey(index),
                    l10n.forgotPasswordTitle,
                    style: FontsStyles.bold.copyWith(fontSize: 24),
                  ),
                ),
              ),


              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Text(
                  key: ValueKey(index),
                  isPhone
                      ? l10n.forgotPasswordPhoneDescription
                      : l10n.forgotPasswordEmailDescription,
                  style: FontsStyles.regular.copyWith(
                    fontSize: 13,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),
              ),

              const Gap(28),

              // Champ téléphone ou email
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: index == 0
                    ? DefaultPhoneField(
                  key: const ValueKey('phone'),
                  controller: phoneController,
                  selectedCountry: selectedCountry,
                  onChanged: (v) => setState(() {}),
                  updateSelectedCountry: (val) {
                    setState(() {
                      selectedCountry = val;
                      phoneController.clear();
                    });
                  },
                )
                    : DefaultField(
                  key: const ValueKey('email'),
                  controller: emailController,
                  label: l10n.email,
                  hintText: l10n.email,
                  prefixIconUrl: AssetsIcons.google,
                  onChanged: (v) => setState(() {}),
                ),
              ),

              const Gap(16),

              // Lien switch téléphone / email
              GestureDetector(
                onTap: () {
                  setState(() => index = isPhone ? 1 : 0);
                  phoneController.clear();
                  emailController.clear();
                },
                child: Text(
                  isPhone ? l10n.useEmail : l10n.usePhoneNumber,
                  style: FontsStyles.regular.copyWith(
                    color: Palette.petrolBlue,
                    fontSize: 13,
                    decoration: TextDecoration.underline,
                    decorationColor: Palette.petrolBlue,
                    decorationThickness: 1.2,
                  ),
                ),
              ),

              const Spacer(),

              // Bouton suivant
              DefaultButton(
                isEnable: _isFormValid(),
                bgColor: Palette.petrolBlue,
                onTap: submitForm,
                text: l10n.next,
                padding: 16,
                textStyle: FontsStyles.regular.copyWith(
                  fontSize: 16,
                  color: Palette.white,
                ),
              ),

              const Gap(24),
            ],
          ),
        ),
      ),
    );
  }
}