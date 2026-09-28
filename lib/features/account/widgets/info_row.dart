import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({super.key,
    required this.label,
    required this.value,
    this.valueColor,
    this.actionText,
    this.onAction,
    this.isLast = false,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final String? actionText;
  final VoidCallback? onAction;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 14, 16, isLast ? 14 : 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         Expanded(
           child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: FontsStyles.regular.copyWith(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                ),
                const Gap(2),
                Text(
                  value,
                  style: FontsStyles.bold.copyWith(
                    fontSize: 14,
                    color: valueColor ?? Palette.black,
                  ),
                ),
              ],
            ),
         ),
          if (actionText != null && onAction != null)
            GestureDetector(
              onTap: onAction,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Palette.petrolBlue.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Text(
                  actionText!,
                  style: FontsStyles.bold.copyWith(
                    fontSize: 12,
                    color: Palette.petrolBlue,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}