import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:corrispay/app/design/palette.dart';
import 'package:flutter/material.dart';

class AmountChip extends StatelessWidget {
  const AmountChip({
    super.key,
    required this.value,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Palette.petrolBlue.withOpacity(0.07),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        value,
        style: FontsStyles.bold.copyWith(
          fontSize: 11,
          color: Palette.petrolBlue,
        ),
      ),
    );
  }
}