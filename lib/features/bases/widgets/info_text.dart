import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:corrispay/app/design/palette.dart';
import 'package:flutter/material.dart';

class InfoText extends StatelessWidget {
  const InfoText({
    super.key,
    required this.value,
    this.color,
  });

  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: FontsStyles.bold.copyWith(
        fontSize: 13,
        color: color ?? Palette.black,
      ),
    );
  }
}