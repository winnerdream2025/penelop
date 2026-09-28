import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:flutter/material.dart';

class RechargeInfoRow extends StatelessWidget {
  const RechargeInfoRow({
    super.key,
    required this.label,
    required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: FontsStyles.regular.copyWith(
              fontSize: 13,
              color: Colors.grey.shade500,
            ),
          ),
          child,
        ],
      ),
    );
  }
}