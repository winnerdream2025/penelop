import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../app/design/assets/assets_ressources.dart';
import '../../../app/design/palette.dart';
import '../../../l10n/app_localizations.dart';
import '../../transactions/models/mobile_money.dart';

class MobileMoneyTile extends StatelessWidget {
  const MobileMoneyTile({
    super.key,
    required this.mobileMoney,
    required this.updateMobileMoney,
    required this.isSelected,
  });

  final MobileMoney mobileMoney;
  final Function(MobileMoney) updateMobileMoney;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () {
        updateMobileMoney(mobileMoney);
        Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Palette.white,
                  radius: 24,
                  backgroundImage: AssetImage(AssetsRessources.togocom),
                ),
                Gap(8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mobileMoney.name,
                      style: FontsStyles.bold.copyWith(
                        color: Palette.black,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "${tr.fees} :  ${tr.currency}",
                      style: FontsStyles.regular.copyWith(
                        color: Palette.black,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: isSelected ? Palette.petrolBlue : Palette.white,
                shape: BoxShape.circle,
                border: Border.all(color: Palette.petrolBlue, width: 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
