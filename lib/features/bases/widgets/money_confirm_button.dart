import 'package:corrispay/app/design/assets/assets_icons.dart';
import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:corrispay/features/bases/widgets/default_button.dart';
import 'package:corrispay/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../app/design/palette.dart';

class MoneyConfirmBottom extends StatelessWidget {
  const MoneyConfirmBottom({
    super.key,
    required this.label,
    required this.onTap,
    this.showWarning = true,
  });

  final String label;
  final VoidCallback onTap;
  final bool showWarning;

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          if (showWarning) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF1E6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.error_outline_rounded,
                    size: 15,
                    color: Palette.orange,
                  ),
                  const Gap(8),
                  Expanded(
                    child: Text(
                      tr.irreversible_operation_warning,
                      style: FontsStyles.regular.copyWith(
                        fontSize: 11,
                        color: const Color(0xFF854F0B),
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(14),
          ],

          DefaultButton(
            text: label,
            bgColor: Palette.petrolBlue,
            hPadding: 16,
            onTap: onTap,
          ),

          const Gap(10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AssetsIcons.lock,
                colorFilter: ColorFilter.mode(
                  Colors.grey.shade500,
                  BlendMode.srcIn,
                ),
                width: 16,
                height: 16,
              ),
              const Gap(8),
              Text(
                tr.secure_payment,
                style: FontsStyles.regular.copyWith(
                  fontSize: 11,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
