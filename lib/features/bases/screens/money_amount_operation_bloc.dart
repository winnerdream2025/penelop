import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:corrispay/features/bases/widgets/fees_pill.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../app/design/palette.dart';
import '../../../l10n/app_localizations.dart';

class MoneyAmountOperationBloc extends StatelessWidget {
  const MoneyAmountOperationBloc({
    super.key,
    required this.amount,
    required this.netAmount,
    required this.fee,
    required this.currency,
    required this.title
  });

  final double amount;
  final double netAmount;
  final double fee;
  final String currency;
  final String title;

  bool get _hasFee => fee > 0;

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 22),
      child: Column(
        children: [
          Text(
           title,
            style: FontsStyles.medium.copyWith(
              fontSize: 12,
              color: Colors.grey.shade500,
            ),
          ),

          const Gap(6),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                amount.toStringAsFixed(0),
                style: FontsStyles.bold.copyWith(
                  fontSize: 48,
                  color: Palette.black,
                ),
              ),
              const Gap(5),
              Text(
                currency,
                style: FontsStyles.medium.copyWith(
                  fontSize: 15,
                  color: const Color(0xFFB0B0B0),
                ),
              ),
            ],
          ),

          const Gap(16),


          if (_hasFee)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FeesPill(
                  label: tr.net,
                  value: '${netAmount.toStringAsFixed(0)} $currency',
                ),
                const Gap(8),
                FeesPill(
                  label: tr.fees,
                  value: '${fee.toStringAsFixed(0)} $currency',
                ),
              ],
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle_rounded, size: 14, color: Palette.teal),
                const Gap(5),
                Text(
                  tr.noFeesApplied,
                  style: FontsStyles.medium.copyWith(
                    fontSize: 12,
                    color: Palette.teal,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
