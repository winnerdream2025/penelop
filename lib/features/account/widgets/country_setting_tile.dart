import 'package:corrispay/app/design/assets/flag_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../../../app/design/assets/assets_icons.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../../transactions/models/country.dart';

class CountrySettingTile extends StatelessWidget {
  const CountrySettingTile({
    super.key,
    required this.countryModel,
    required this.title,
    required this.onTap,
  });
  final String title;
  final VoidCallback onTap;
  final Country countryModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(color: Colors.grey.shade50),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: FontsStyles.regular.copyWith(
                fontSize: 18,
                color: Palette.black,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    countryModel.countryName,
                    style: FontsStyles.bold.copyWith(
                      fontSize: 18,
                      color: Palette.black,
                    ),
                  ),
                ),
                Gap(4),
                Image.asset(FlagAssets.gb, width: 24, height: 24),
                SvgPicture.asset(AssetsIcons.arrowRightIos),
              ],
            ),
          ],
        ),
      ),
    );
  }
}