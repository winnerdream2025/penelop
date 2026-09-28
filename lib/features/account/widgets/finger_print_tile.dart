import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../app/design/assets/assets_icons.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';

class FingerPrintTile extends StatelessWidget {
  const FingerPrintTile({super.key,required this.onTap,required this.title,required this.value});
  final String title;
  final VoidCallback onTap;
  final String value;


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
                Text(
                 value,
                  style: FontsStyles.bold.copyWith(
                    fontSize: 18,
                    color: Palette.black,
                  ),
                ),
                Gap(4),
                SvgPicture.asset(AssetsIcons.arrowRightIos),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
