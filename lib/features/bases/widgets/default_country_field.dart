import 'package:corrispay/app/design/assets/assets_icons.dart';
import 'package:corrispay/app/design/assets/flag_assets.dart';
import 'package:corrispay/features/transactions/models/country_operator_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../../transactions/models/country.dart';
import '../screens/country_choice_screen.dart';

class DefaultCountryField extends StatefulWidget {
  const DefaultCountryField({
    super.key,
    required this.country,
    required this.onTap,
    this.label,
    required this.countries,
  });

  final CountryOperatorModel country;
  final Function(CountryOperatorModel) onTap;
  final String? label;
  final List<CountryOperatorModel> countries;

  @override
  State<DefaultCountryField> createState() => _DefaultCountryFieldState();
}

class _DefaultCountryFieldState extends State<DefaultCountryField> {
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: FontsStyles.regular.copyWith(
              fontSize: 13,
              color: Palette.black,
            ),
          ),
          Gap(4),
        ],
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
              builder: (context) => CountryChoiceScreen(
                countries: widget.countries,
                updateSelectedCountry: widget.onTap,
                selectedCountry: widget.country,
              ),
            );
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 8),
            height: 48,
            key: _key,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFE2E8F0), width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Image.asset(
                      FlagAssets.url(widget.country.countryCode),
                      width: 30,
                    ),
                    Gap(4),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        widget.country.label,
                        style: FontsStyles.medium.copyWith(
                          color: Palette.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                SvgPicture.asset(
                  AssetsIcons.arrowDownIos,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    Palette.black,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

List<CountryOperatorModel> countries = [
  /**
   *  CountryOperatorModel(
      label: "AFRIQUE DU SUD",
      key: "afrique_du_sud",
      operators: [],
      countryCode: "ZA",
      dialCode: "27",
      phoneLength: 9,
      ),
      CountryOperatorModel(
      label: "BELGIQUE",
      key: "belgique",
      operators: [],
      countryCode: "BE",
      dialCode: "32",
      phoneLength: 9,
      ),*/
      CountryOperatorModel(
      label: "BENIN",
      key: "benin",
      operators: [],
      countryCode: "BJ",
      dialCode: "229",
      phoneLength: 8,
      ),
      CountryOperatorModel(
      label: "BURKINA FASO",
      key: "burkina_faso",
      operators: [],
      countryCode: "BF",
      dialCode: "226",
      phoneLength: 8,
      ),/*
      CountryOperatorModel(
      label: "CAMEROUN",
      key: "cameroun",
      operators: [],
      countryCode: "CM",
      dialCode: "237",
      phoneLength: 9,
      ),
      CountryOperatorModel(
      label: "COTE D'IVOIRE",
      key: "cote_ivoire",
      operators: [],
      countryCode: "CI",
      dialCode: "225",
      phoneLength: 10,
      ),
      CountryOperatorModel(
      label: "FRANCE",
      key: "france",
      operators: [],
      countryCode: "FR",
      dialCode: "33",
      phoneLength: 9,
      ),
      CountryOperatorModel(
      label: "GERMANY",
      key: "germany",
      operators: [],
      countryCode: "DE",
      dialCode: "49",
      phoneLength: 10,
      ),
      CountryOperatorModel(
      label: "GHANA",
      key: "ghana",
      operators: [],
      countryCode: "GH",
      dialCode: "233",
      phoneLength: 9,
      ),
      CountryOperatorModel(
      label: "GUINEE",
      key: "guinee",
      operators: [],
      countryCode: "GN",
      dialCode: "224",
      phoneLength: 9,
      ),
      CountryOperatorModel(
      label: "KENYA",
      key: "kenya",
      operators: [],
      countryCode: "KE",
      dialCode: "254",
      phoneLength: 9,
      ),
      CountryOperatorModel(
      label: "LUXEMBOURG",
      key: "luxembourg",
      operators: [],
      countryCode: "LU",
      dialCode: "352",
      phoneLength: 9,
      ),
      CountryOperatorModel(
      label: "MALI",
      key: "mali",
      operators: [],
      countryCode: "ML",
      dialCode: "223",
      phoneLength: 8,
      ),
      CountryOperatorModel(
      label: "NIGER",
      key: "niger",
      operators: [],
      countryCode: "NE",
      dialCode: "227",
      phoneLength: 8,
      ),
      CountryOperatorModel(
      label: "NIGERIA",
      key: "nigeria",
      operators: [],
      countryCode: "NG",
      dialCode: "234",
      phoneLength: 10,
      ),
   */
  CountryOperatorModel(
    label: "SENEGAL",
    key: "senegal",
    operators: [],
    countryCode: "SN",
    dialCode: "221",
    phoneLength: 9,
  ),
  /**
   *  CountryOperatorModel(
      label: "TCHAD",
      key: "tchad",
      operators: [],
      countryCode: "TD",
      dialCode: "235",
      phoneLength: 8,
      ),
   */
  CountryOperatorModel(
    label: "TOGO",
    key: "togo",
    operators: [],
    countryCode: "TG",
    dialCode: "228",
    phoneLength: 8,
  ),
  /**
   *  CountryOperatorModel(
      label: "UNITED STATES",
      key: "united_states",
      operators: [],
      countryCode: "US",
      dialCode: "1",
      phoneLength: 10,
      ),
   */
];

class CountryDropDown extends StatelessWidget {
  const CountryDropDown({
    super.key,
    required this.country,
    required this.isExpanded,
    required this.chooseCountry,
    required this.onTapOutside,
    required this.countries,
  });

  final Country country;
  final Function(Country) chooseCountry;
  final bool isExpanded;
  final VoidCallback onTapOutside;
  final List<Country> countries;

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapOutside: (event) => onTapOutside(),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
          height: isExpanded ? null : 0,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Palette.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: countries.asMap().entries.map((entry) {
              final index = entry.key;
              final countryItem = entry.value;
              return Padding(
                padding: EdgeInsets.only(bottom: index == 0 ? 8 : 0),
                child: CountryTile(
                  isActive: countryItem == country,
                  isLast: index == countries.length - 1,
                  countryModel: countryItem,
                  onTap: () => chooseCountry(countryItem),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class CountryTile extends StatelessWidget {
  const CountryTile({
    super.key,
    required this.countryModel,
    required this.onTap,
    required this.isActive,
    required this.isLast,
  });

  final Country countryModel;
  final VoidCallback onTap;
  final bool isActive;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isActive
                  ? Palette.petrolBlue.withOpacity(0.1)
                  : Palette.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  countryModel.countryName,
                  style: FontsStyles.regular.copyWith(color: Palette.black),
                ),
                Row(
                  children: [
                    Text(
                      countryModel.dialCode,
                      style: FontsStyles.medium.copyWith(color: Palette.black),
                    ),
                    const Gap(24),
                    if (isActive) const Icon(Icons.check, size: 16),
                  ],
                ),
              ],
            ),
          ),
          if (!isLast) const Gap(12),
          if (!isLast)
            Container(
              height: 1,
              width: double.infinity,
              color: const Color(0xFFE7E7E7),
            ),
        ],
      ),
    );
  }
}
