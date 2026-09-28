import 'package:corrispay/app/routes/routes_names.dart';
import 'package:corrispay/features/auth/dto/login_phone.dto.dart';
import 'package:corrispay/features/auth/dto/login_with_email.dto.dart';
import 'package:corrispay/features/auth/providers/auth_provider.dart';
import 'package:corrispay/features/bases/widgets/default_phone_field.dart';
import 'package:corrispay/features/transactions/models/country_operator_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/design/assets/assets_icons.dart';
import '../../../../app/design/fonts_styles.dart';
import '../../../../app/design/palette.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../core/utils/functions.dart';
import '../../bases/providers/country_provider.dart';
import '../../bases/widgets/default_button.dart';
import '../../bases/widgets/default_country_field.dart';
import '../../bases/widgets/default_field.dart';
import '../../bases/widgets/rounded_back_button.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  CountryOperatorModel? selectedCountry;
  int index = 0;
  bool isObscur = true;

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
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  bool _isFormValid() {
    return index == 0
        ? _phoneController.text.length == selectedCountry!.phoneLength &&
              _passwordController.text.isNotEmpty
        : _emailController.text.isNotEmpty &&
              _passwordController.text.isNotEmpty;
  }

  void submitForm() async {
    FocusScope.of(context).unfocus();
    final fcmToken = await ref.read(fcmTokenProvider.future) ?? '';

    showLoading();
    final response = index == 0
        ? await ref.read(
            loginPhoneProvider(
              LoginPhoneDto(
                phoneNumber: selectedCountry!.dialCode + _phoneController.text,
                password: _passwordController.text,
                fcmToken: fcmToken,
              ),
            ).future,
          )
        : await ref.read(
            loginEmailProvider(
              LoginWithEmailDto(
                email: _emailController.text,
                password: _passwordController.text,
                fcmToken: fcmToken,
              ),
            ).future,
          );
    hideLoading();

    if (response != null && response.status && response.data != null) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesNames.main,
        (route) => false,
        arguments: response.data!.dashboardData,
      );
    } else {
      showErrorMessage(response?.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final isPhone = index == 0;

    return PopScope(
      onPopInvoked: (didPop) => FocusScope.of(context).unfocus(),
      child: Scaffold(
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

                Text(
                  t.loginTitle,
                  style: FontsStyles.bold.copyWith(fontSize: 24),
                ),

                Text(
                  isPhone ? t.loginWithPhone : t.loginWithEmail,
                  style: FontsStyles.regular.copyWith(
                    fontSize: 13,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),

                const Gap(16),

                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: isPhone
                      ? DefaultPhoneField(
                          key: const ValueKey('phone'),
                          controller: _phoneController,
                          selectedCountry: selectedCountry!,
                          onChanged: (v) => setState(() {}),
                          updateSelectedCountry: (val) {
                            setState(() => selectedCountry = val);
                            _phoneController.clear();
                          },
                        )
                      : DefaultField(
                          key: const ValueKey('email'),
                          controller: _emailController,
                          label: t.email,
                          hintText: t.email,
                          prefixIconUrl: AssetsIcons.google,
                          onChanged: (v) => setState(() {}),
                        ),
                ),

                DefaultField(
                  controller: _passwordController,
                  label: t.password,
                  prefixIconUrl: AssetsIcons.phone,
                  suffixIconUrl: isObscur
                      ? AssetsIcons.eyeOff
                      : AssetsIcons.eyeOn,
                  hintText: t.password,
                  isObscur: isObscur,
                  onChanged: (v) => setState(() {}),
                  changeObscur: () => setState(() => isObscur = !isObscur),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      RoutesNames.forgotPassword,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        t.forgotPassword,
                        style: FontsStyles.regular.copyWith(
                          fontSize: 12,
                          color: Palette.petrolBlue,
                          decoration: TextDecoration.underline,
                          decorationColor: Palette.petrolBlue,
                        ),
                      ),
                    ),
                  ),
                ),

                const Gap(24),

                DefaultButton(
                  isEnable: _isFormValid(),
                  onTap: submitForm,
                  bgColor: Palette.petrolBlue,
                  text: t.loginButton,
                  padding: 16,
                  textStyle: FontsStyles.regular.copyWith(
                    fontSize: 16,
                    color: Palette.white,
                  ),
                ),

                const Gap(16),

                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade200)),
                    const Gap(12),
                    Text(
                      t.orLoginWith,
                      style: FontsStyles.regular.copyWith(
                        fontSize: 12,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    const Gap(12),
                    Expanded(child: Divider(color: Colors.grey.shade200)),
                  ],
                ),

                const Gap(16),

                DefaultButton(
                  padding: 12,
                  text: isPhone ? t.emailMode : t.phoneMode,
                  suffixIcon: isPhone ? AssetsIcons.email : AssetsIcons.phone,
                  bgColor: Palette.white,
                  textColor: Palette.black,
                  brColor: Palette.petrolBlue,
                  iconColor: Palette.black,
                  onTap: () {
                    setState(() => index = isPhone ? 1 : 0);
                    _emailController.clear();
                    _phoneController.clear();
                    _passwordController.clear();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
