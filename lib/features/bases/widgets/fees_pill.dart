import 'package:corrispay/app/design/palette.dart';
import 'package:flutter/material.dart';
import '../../../app/design/fonts_styles.dart';

class FeesPill extends StatelessWidget {
  const FeesPill({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: RichText(
        text: TextSpan(
          style: FontsStyles.regular.copyWith(
            fontSize: 11,
            color: Palette.black,
          ),
          children: [
            TextSpan(text: '$label '),
            TextSpan(
              text: value,
              style: FontsStyles.bold.copyWith(
                fontSize: 11,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}