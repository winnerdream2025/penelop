import 'package:corrispay/core/local/userlocal_provider.dart';
import 'package:corrispay/features/mobiles-transactions/responses/mobile_withdrawal_preview_data.dart';
import 'package:corrispay/features/transactions/models/withdrawal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:corrispay/app/design/palette.dart';
import 'package:corrispay/app/routes/routes_names.dart';
import 'package:corrispay/features/bases/widgets/default_button.dart';
import '../responses/withdrawal_response.dart';
import '../../../l10n/app_localizations.dart';

class ConfirmWithdrawalView extends ConsumerWidget {
  const ConfirmWithdrawalView({super.key, required this.transaction});
  final MobileWithdrawalPreviewData transaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = AppLocalizations.of(context)!;
    final user = ref.watch(userLocalProvider);
    return Scaffold(
      backgroundColor: Palette.white,
      appBar: AppBar(backgroundColor: Palette.white),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr.confirm_withdrawal,
              style: FontsStyles.bold.copyWith(
                color: Palette.petrolBlue,
                fontSize: 32,
              ),
            ),

            const Gap(32),

            Text(
              tr.sender,
              style: FontsStyles.bold.copyWith(
                color: Palette.black,
                fontSize: 20,
              ),
            ),
            Divider(),
            Gap(12),
            //WithdrawalItem(title: tr.account_number, value: transaction.account),
            WithdrawalItem(
              title: tr.amount_to_be_withdrawn,
              value:
                  "${(transaction.amount).toStringAsFixed(2)} ${user!.targetCurrency}",
            ),
            WithdrawalItem(
              title: tr.withdrawal_fees,
              value:
                  "${((transaction.corisFee+transaction.providerFee) ).toStringAsFixed(2)} ${user.targetCurrency}",
            ),
            WithdrawalItem(
              title:tr.withdrawal_amount,
              value:
                  "${(transaction.amount).toStringAsFixed(2)} ${user.targetCurrency}",
            ),
            Gap(48),
            Text(
              tr.recipient,
              style: FontsStyles.bold.copyWith(
                color: Palette.black,
                fontSize: 20,
              ),
            ),
            Divider(),
            Gap(12),

            Gap(8),
            WithdrawalItem(title:tr.netWork, value: transaction.operator),
            WithdrawalItem(
              title: tr.phone_number,
              value: transaction.phoneNumber,
            ),
            WithdrawalItem(
              title: tr.amount_to_be_received,
              value:
                  "${(transaction.netAmount).toStringAsFixed(2)} ",
            ),

            const Spacer(),

            DefaultButton(
              text: tr.confirm_withdrawal,
              bgColor: Palette.petrolBlue,
              padding: 14,
              hPadding: 14,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RoutesNames.enterWithdrawalCode,
                  arguments: transaction,
                );
              },
            ),

            const Gap(24),
          ],
        ),
      ),
    );
  }
}

class WithdrawalItem extends StatelessWidget {
  const WithdrawalItem({super.key, required this.value, required this.title});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: FontsStyles.regular.copyWith(
              color: Palette.black,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: FontsStyles.regular.copyWith(
              color: Palette.petrolBlue,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
