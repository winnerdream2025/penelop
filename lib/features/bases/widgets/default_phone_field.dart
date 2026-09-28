import 'package:corrispay/app/design/assets/flag_assets.dart';
import 'package:corrispay/features/bases/screens/pick_country_code_screen.dart';
import 'package:corrispay/features/transactions/models/country_operator_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import '../../../app/design/assets/assets_icons.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../../../l10n/app_localizations.dart';
import 'default_field.dart';

class DefaultPhoneField extends StatelessWidget {
  const DefaultPhoneField({
    super.key,
    required this.controller,
    required this.selectedCountry,
    required this.updateSelectedCountry,
    required this.onChanged,
  });
  final TextEditingController controller;
  final CountryOperatorModel selectedCountry;
  final Function(CountryOperatorModel) updateSelectedCountry;
  final Function(String?) onChanged;
  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr.phoneNumber,
          style: FontsStyles.regular.copyWith(color: Palette.black),
        ),
        Gap(4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  isDismissible: true,
                  constraints: BoxConstraints(
                    maxHeight: 0.95 * MediaQuery.of(context).size.height,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  builder: (context) => PickCountryCodeScreen(
                    selectedCountry: selectedCountry,
                    updateSelectedCountry: updateSelectedCountry,
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                height: 52,
                decoration: BoxDecoration(
                  color: Palette.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      FlagAssets.url(selectedCountry.countryCode),
                      width: 25,
                    ),
                    Gap(4),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Center(
                        child: Text(
                          "+${selectedCountry.dialCode}",
                          style: FontsStyles.regular.copyWith(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gap(8),

            Expanded(
              child: DefaultField(
                controller: controller,
                hintText: tr.phoneNumberHint,
                inputsFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(
                    selectedCountry.phoneLength.toInt(),
                  ),
                ],
                type: TextInputType.number,
                onChanged: onChanged,
                prefixIconUrl: AssetsIcons.phone,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
