import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:flutter/material.dart';
import '../../../app/design/palette.dart';

class RechargePendingItem extends StatelessWidget {
  const RechargePendingItem({
    super.key,
    required this.itemKey,
    required this.value,
    this.hasBG = true,
    this.paddingBT,
  });
  final String itemKey;
  final String value;
  final bool? hasBG;
  final double? paddingBT;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: paddingBT ?? 16),
      padding: EdgeInsets.all(12),
      decoration: hasBG == true
          ? BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      )
          : null,
      child: Row(
        children: [
          Text(
            itemKey,
            style: FontsStyles.regular.copyWith(color: Palette.black),
          ),
          Spacer(),
          Text(
            value,
            style: FontsStyles.bold.copyWith(color: Palette.petrolBlue),
          ),
        ],
      ),
    );
  }
}
