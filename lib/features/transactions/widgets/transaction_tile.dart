import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_time_ago/get_time_ago.dart';
import '../../../app/design/assets/assets_icons.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../../../l10n/app_localizations.dart';
import '../../bases/providers/language_provider.dart';
import '../models/transaction.dart';

class TransactionTile extends ConsumerWidget {
  const TransactionTile({
    super.key,
    required this.transaction,
    required this.exchangeRate,
    required this.currency,
  });
  final Transaction transaction;
  final double exchangeRate;
  final String currency;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = AppLocalizations.of(context)!;
    final locale = ref.watch(localeProviderState);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey.shade200,
                  child: SvgPicture.asset(
                    AssetsIcons.check,
                    colorFilter: ColorFilter.mode(
                      transaction.statut != "SUCCESS"
                          ? Colors.red
                          : Colors.green,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                SizedBox(width: 4),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.name,
                      style: FontsStyles.medium.copyWith(
                        color: Palette.black,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      GetTimeAgo.parse(
                        transaction.date,
                        locale: locale.locale.toString(),
                      ),
                      style: FontsStyles.regular.copyWith(
                        color: Palette.black,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RichText(
                text: TextSpan(
                  text: transaction.montant.toString(),
                  style: FontsStyles.medium.copyWith(
                    color: Palette.black,
                    fontSize: 14,
                  ),
                  children: [
                    TextSpan(
                      text: " ${currency}",
                      style: FontsStyles.regular.copyWith(
                        color: Palette.black,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                transaction.type,
                style: FontsStyles.regular.copyWith(
                  color: transaction.statut != "SUCCESS"
                      ? Colors.red
                      : Colors.green,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
