import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:corrispay/app/design/palette.dart';
import 'package:corrispay/app/routes/routes_names.dart';
import 'package:corrispay/core/local/userlocal_provider.dart';
import 'package:corrispay/features/bases/widgets/money_confirm_button.dart';
import 'package:corrispay/features/bases/widgets/rounded_close_button.dart';
import 'package:corrispay/features/mobiles-transactions/responses/mobile_withdrawal_preview_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../l10n/app_localizations.dart';
import '../widgets/recharge_chip.dart';
import '../widgets/recharge_info_row.dart';

class WithdrawalSummaryView extends ConsumerWidget {
  const WithdrawalSummaryView({super.key, required this.data});

  final MobileWithdrawalPreviewData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userLocalProvider);
    final currency = user?.targetCurrency ?? '';
    final tr = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Palette.white,
      appBar: AppBar(
        backgroundColor: Palette.white,
        elevation: 0,
        leading: RoundedCloseButton(),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Column(
                          children: [
                            Text(
                              tr.withdrawal_confirmation,
                              style: FontsStyles.medium.copyWith(
                                fontSize: 15,
                                color: Colors.grey.shade500,
                              ),
                            ),

                            const Gap(12),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.amountToDebit.toStringAsFixed(0),
                                  style: FontsStyles.bold.copyWith(
                                    fontSize: 52,
                                    color: Palette.black,
                                    letterSpacing: -3,
                                    height: 1,
                                  ),
                                ),
                                const Gap(4),
                                Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Text(
                                    currency,
                                    style: FontsStyles.medium.copyWith(
                                      fontSize: 20,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const Gap(12),

                            const Gap(32),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 1,
                        child: ColoredBox(color: Color(0xFFF0F0F0)),
                      ),

                      const Gap(24),

                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFFF0F0F0),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          children: [
                            RechargeInfoRow(
                              label: tr.phone_number,
                              child: Text(
                                data.phoneNumber,
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
                                label: data.country.toUpperCase(),
                                color: Palette.petrolBlue,
                              ),
                            ),

                            const Divider(height: 1, color: Color(0xFFF8F8F8)),

                            RechargeInfoRow(
                              label: tr.operator,
                              child: RechargeChip(
                                label: data.operator.toUpperCase(),
                                color: Palette.orange,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              MoneyConfirmBottom(
                label: tr.confirm,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RoutesNames.enterWithdrawalCode,
                    arguments: data,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
