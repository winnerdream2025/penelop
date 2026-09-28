import 'package:corrispay/features/bases/widgets/rounded_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../../../app/routes/routes_names.dart';
import '../../../core/utils/functions.dart';
import '../../../l10n/app_localizations.dart';
import '../../bases/providers/country_provider.dart';
import '../../bases/widgets/default_button.dart';
import '../../bases/widgets/default_country_field.dart';
import '../../bases/widgets/default_phone_field.dart';
import '../../transactions/models/country_operator_model.dart';
import '../dto/send-phone-otp.dto.dart';
import '../providers/otp_provider.dart';

class ForgotPincodeView extends ConsumerStatefulWidget {
  const ForgotPincodeView({super.key, this.canLogin = false});
  final bool? canLogin;

  @override
  ConsumerState<ForgotPincodeView> createState() => _ForgotPincodeViewState();
}

class _ForgotPincodeViewState extends ConsumerState<ForgotPincodeView> {
  TextEditingController phoneController = TextEditingController();
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
    super.dispose();
  }

  bool _isFormValid() {
    return phoneController.text.length == selectedCountry.phoneLength;
  }

  void submitForm() async {
    FocusScope.of(context).unfocus();
    showLoading();

    final response = await ref.read(
      sendResetPasswordCodeProvider(
        SendPhoneOtpDto(
          phoneNumber: selectedCountry.dialCode + phoneController.text,
        ),
      ).future,
    );

    hideLoading();
    if (response != null && response.status) {
      Navigator.pushNamed(
        context,
        RoutesNames.confirmResetPinCode,
        arguments: selectedCountry.dialCode + phoneController.text,
      );
      //showSuccessMessage(response.message);
    } else {
      showErrorMessage(response?.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Palette.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(widget.canLogin==false)...[
                RoundedBackButton(),
              ],
              const Gap(24),

              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: Palette.petrolBlue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.lock_open_rounded,
                  color: Palette.petrolBlue,
                  size: 26,
                ),
              ),

              const Gap(16),

              Text(
                l10n.forgotPinTitle,
                style: FontsStyles.bold.copyWith(fontSize: 24),
              ),

              const Gap(6),

              Text(
                l10n.forgotPinDescription,
                textAlign: TextAlign.center,
                style: FontsStyles.regular.copyWith(
                  fontSize: 13,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),

              const Gap(28),

              DefaultPhoneField(
                controller: phoneController,
                selectedCountry: selectedCountry,
                onChanged: (v) {
                  setState(() {});
                },
                updateSelectedCountry: (val) {
                  setState(() {
                    selectedCountry = val;
                  });
                },
              ),

              const Spacer(),

              if (widget.canLogin!) ...[
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        RoutesNames.loginWithPinCode,
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "${l10n.rememberPin} ",
                        style: FontsStyles.regular.copyWith(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                        children: [
                          TextSpan(
                            text: l10n.loginHere,
                            style: FontsStyles.regular.copyWith(
                              fontSize: 13,
                              color: Palette.petrolBlue,
                              decoration: TextDecoration.underline,
                              decorationColor: Palette.petrolBlue,
                              decorationThickness: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const Gap(16),
              ],

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
