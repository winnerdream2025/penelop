import 'package:corrispay/core/utils/custom_inputs_formatters.dart';
import 'package:corrispay/features/auth/dto/register.dto.dart';
import 'package:corrispay/features/auth/providers/otp_provider.dart';
import 'package:corrispay/features/bases/widgets/rounded_back_button.dart';
import 'package:corrispay/features/transactions/models/country_operator_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/design/assets/assets_icons.dart';
import '../../../../app/design/fonts_styles.dart';
import '../../../../app/design/palette.dart';
import '../../../../app/routes/routes_names.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../core/utils/functions.dart';
import '../../bases/providers/country_provider.dart';
import '../../bases/widgets/default_button.dart';
import '../../bases/widgets/default_country_field.dart';
import '../../bases/widgets/default_field.dart';
import '../dto/send-phone-otp.dto.dart';

class PhoneView extends ConsumerStatefulWidget {
  const PhoneView({super.key});

  @override
  ConsumerState<PhoneView> createState() => _PhoneViewState();
}

class _PhoneViewState extends ConsumerState<PhoneView> {
  TextEditingController phoneController = TextEditingController();
  bool isPhoneNumberValid = false;
  CountryOperatorModel? selectedCountry;

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
            phoneController.text.length == selectedCountry?.phoneLength;
      });
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void submitForm() async {
    FocusScope.of(context).unfocus();
    showLoading();
    final response = await ref.read(
      sendCodeProvider(
        SendPhoneOtpDto(
          phoneNumber: selectedCountry!.dialCode + phoneController.text,
        ),
      ).future,
    );
    hideLoading();

    if (response != null && response.status) {
      Navigator.pushNamed(
        context,
        RoutesNames.otp,
        arguments: RegisterDto(
          phoneNumber: selectedCountry!.dialCode + phoneController.text,
          country: selectedCountry?.label,
        ),
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
      resizeToAvoidBottomInset: true,
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
                  Icons.phone_outlined,
                  color: Palette.petrolBlue,
                  size: 26,
                ),
              ),

              const Gap(8),


              Text(
                l10n.phoneTitle,
                style: FontsStyles.bold.copyWith(fontSize: 24),
              ),

              const Gap(4),


              Text(
                l10n.phoneDescription,
                style: FontsStyles.regular.copyWith(
                  fontSize: 13,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),

              const Gap(16),


              DefaultCountryField(
                countries: countries,
                label: l10n.country,
                country: selectedCountry!,
                onTap: (val) {
                  setState(() {
                    selectedCountry = val;
                    phoneController.clear();
                  });
                },
              ),

              const Gap(16),

             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [

                 Text(
                   l10n.phoneNumber,
                   style: FontsStyles.regular.copyWith(
                     color: Colors.black87,
                     fontSize: 13,
                   ),
                 ),

                 const Gap(6),

                 Row(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     // Indicatif
                     Container(
                       padding: const EdgeInsets.symmetric(horizontal: 12),
                       height: 52,
                       decoration: BoxDecoration(
                         color: Colors.grey.shade50,
                         borderRadius: BorderRadius.circular(12),
                         border: Border.all(color: const Color(0xFFE2E8F0)),
                       ),
                       child: Center(
                         child: Text(
                           "+${selectedCountry?.dialCode}",
                           style: FontsStyles.regular.copyWith(
                             fontSize: 14,
                             color: Colors.black87,
                           ),
                         ),
                       ),
                     ),
                     const Gap(8),
                     // Champ numéro
                     Expanded(
                       child: DefaultField(
                         controller: phoneController,
                         hintText: l10n.phoneNumber,
                         prefixIconUrl: AssetsIcons.phone,
                         type: TextInputType.number,
                         inputsFormatters: [
                           PhoneNumberFormatter(selectedCountry!.phoneLength),
                           FilteringTextInputFormatter.digitsOnly,
                           LengthLimitingTextInputFormatter(
                             selectedCountry!.phoneLength,
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
               ],
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
          isEnable: isPhoneNumberValid,
          bgColor: Palette.petrolBlue,
          onTap: isPhoneNumberValid ? submitForm : null,
          text: l10n.next,
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