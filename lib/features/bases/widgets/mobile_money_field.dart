import 'package:corrispay/app/design/assets/assets_icons.dart';
import 'package:corrispay/features/transactions/models/country_operator_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../../../l10n/app_localizations.dart';
import '../../mobiles-transactions/screens/mobile_money_choice_screen.dart';

class MobileMoneyField extends StatelessWidget {
  const MobileMoneyField({
    super.key,
    required this.selectedMobileMoney,
    required this.updateSelectedMobileMoney,
    required this.mobilesMoneys,
    required this.countryName,
    required this.countryFlag,
  });
  final Operator selectedMobileMoney;
  final Function(Operator mobileMoney) updateSelectedMobileMoney;
  final List<Operator> mobilesMoneys;
  final String countryName;
  final String countryFlag;

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr.mobileMoney,
          style: FontsStyles.regular.copyWith(
            color: Palette.black,
            fontSize: 16,
          ),
        ),
        Gap(8),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              isDismissible: true,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              builder: (context) => MobileMoneyChoiceScreen(
                selectedMobileMoney: selectedMobileMoney,
                updateSelectedMobileMoney: updateSelectedMobileMoney,
                mobilesMoneys: mobilesMoneys,
                countryFlag: countryFlag,
                countryName: countryName,
              ),
            );
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 8),
            height: 48,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFE2E8F0), width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        selectedMobileMoney.label,
                        style: FontsStyles.medium.copyWith(
                          color: Palette.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                SvgPicture.asset(AssetsIcons.arrowDownIos),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
