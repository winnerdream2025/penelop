import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:flutter/material.dart';

class RechargeChip extends StatelessWidget {
  const RechargeChip({super.key, required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.07),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: FontsStyles.bold.copyWith(fontSize: 11, color: color),
      ),
    );
  }
}