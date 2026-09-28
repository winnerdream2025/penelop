import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../../../l10n/app_localizations.dart';

class Tile extends StatelessWidget {
  const Tile({super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.trailing,
    this.warning = false,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Widget? trailing;
  final bool warning;

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Palette.petrolBlue.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 17, color: Palette.petrolBlue),
            ),
            const Gap(12),
            Expanded(
              child: Row(
                children: [
                  Text(
                    title,
                    style: FontsStyles.regular.copyWith(
                      fontSize: 14,
                      color: Palette.black,
                    ),
                  ),
                  if (warning) ...[
                    const Gap(8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Text(
                        tr.create,
                        style: FontsStyles.bold.copyWith(
                          fontSize: 10,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            trailing ??
                Icon(
                  Icons.chevron_right,
                  size: 18,
                  color: Colors.grey.shade300,
                ),
          ],
        ),
      ),
    );
  }
}