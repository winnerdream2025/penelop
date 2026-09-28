import 'package:corrispay/app/design/palette.dart';
import 'package:corrispay/app/routes/routes_names.dart';
import 'package:corrispay/core/local/userlocal_provider.dart';
import 'package:corrispay/features/bases/screens/money_amount_operation_bloc.dart';
import 'package:corrispay/features/bases/widgets/rounded_close_button.dart';
import 'package:corrispay/features/intern-transactions/widgets/recipient_info_bloc.dart';
import 'package:corrispay/features/intern-transactions/widgets/sender_info_bloc.dart';
import 'package:corrispay/features/transactions/models/intern_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../l10n/app_localizations.dart';
import '../../bases/widgets/money_confirm_button.dart';

class ConfirmSendMoneyView extends ConsumerWidget {
  const ConfirmSendMoneyView({super.key, required this.transaction});

  final InternTransaction transaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userLocalProvider);
    final tr = AppLocalizations.of(context)!;
    final currency = user?.targetCurrency ?? '';

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MoneyAmountOperationBloc(
                        title: tr.transfer,
                        amount: transaction.amount,
                        netAmount: transaction.netAmount,
                        fee: transaction.corisFee,
                        currency: currency,
                      ),

                      SenderInfoBloc(accountNumber: user?.phoneNumber ?? ""),

                      const Gap(20),

                      RecipientInfoBloc(
                        firstName: transaction.recipientFirstName,
                        lastName: transaction.recipientLastName,
                        accountNumber: transaction.recipientPhoneNumber,
                        amount: transaction.amount,
                        currency: transaction.recipientCurrency,
                      ),

                      const Gap(32),
                    ],
                  ),
                ),
              ),

              MoneyConfirmBottom(
                label: tr.confirm_transfer,
                onTap: () => Navigator.pushNamed(
                  context,
                  RoutesNames.enterCode,
                  arguments: transaction,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
