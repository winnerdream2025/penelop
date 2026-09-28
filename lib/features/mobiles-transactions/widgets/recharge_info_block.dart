import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:corrispay/app/design/palette.dart';
import 'package:corrispay/features/mobiles-transactions/widgets/recharge_chip.dart';
import 'package:corrispay/features/mobiles-transactions/widgets/recharge_info_row.dart';
import 'package:corrispay/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class RechargeInfoBlock extends StatelessWidget {
  const RechargeInfoBlock({
    super.key,
    required this.phoneNumber,
    required this.country,
    required this.operator,
    required this.tr,
  });

  final String phoneNumber;
  final String country;
  final String operator;
  final AppLocalizations tr;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFF0F0F0)),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          RechargeInfoRow(
            label: tr.phoneNumber,
            child: Text(
              phoneNumber,
              style: FontsStyles.bold.copyWith(
                fontSize: 13,
                color: Palette.black,
              ),
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF8F8F8)),
          RechargeInfoRow(
            label: tr.country,
            child: RechargeChip(
              label: country.toUpperCase(),
              color: Palette.petrolBlue,
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF8F8F8)),
          RechargeInfoRow(
            label: tr.operator,
            child: RechargeChip(
              label: operator.toUpperCase(),
              color: Palette.orange,
            ),
          ),
        ],
      ),
    );
  }
}