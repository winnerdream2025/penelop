import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.label,
    required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: FontsStyles.regular.copyWith(
              fontSize: 12,
              color: Colors.grey.shade400,
            ),
          ),
          child,
        ],
      ),
    );
  }
}


