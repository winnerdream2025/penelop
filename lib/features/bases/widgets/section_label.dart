import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:corrispay/app/design/palette.dart';
import 'package:flutter/material.dart';

class SectionLabel extends StatelessWidget {
  const SectionLabel({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: FontsStyles.bold.copyWith(
        fontSize: 12,
        color: Palette.orange,
        letterSpacing: 1.0,
      ),
    );
  }
}
