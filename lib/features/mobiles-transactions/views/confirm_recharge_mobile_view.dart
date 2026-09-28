import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:corrispay/app/design/palette.dart';
import 'package:corrispay/core/utils/functions.dart';
import 'package:corrispay/features/bases/widgets/rounded_close_button.dart';
import 'package:corrispay/features/mobiles-transactions/providers/mobile-recharge.provider.dart';
import 'package:corrispay/features/mobiles-transactions/responses/mobile_recharge_preview_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../app/routes/routes_names.dart';
import '../../../core/local/userlocal_provider.dart';
import '../../../l10n/app_localizations.dart';
import '../../bases/screens/money_amount_operation_bloc.dart';
import '../../bases/widgets/money_confirm_button.dart';
import '../dto/add_mobile_money_to_wallet.dto.dart';
import '../widgets/recharge_info_block.dart';

class ConfirmRechargeMobileView extends ConsumerStatefulWidget {
  const ConfirmRechargeMobileView({super.key, required this.data});
  final MobileRechargePreviewData data;

  @override
  ConsumerState<ConfirmRechargeMobileView> createState() =>
      _ConfirmRechargeMobileViewState();
}

class _ConfirmRechargeMobileViewState
    extends ConsumerState<ConfirmRechargeMobileView> {
  Future<void> _submitForm() async {
    showLoading();
    try {
      final response = await ref.read(
        confirmMobileRechargeProvider(
          AddMobileMoneyToWalletDto(
            amount: widget.data.amount,
            phone: widget.data.phoneNumber,
            country: widget.data.country,
            operator: widget.data.operator,
          ),
        ).future,
      );

      if (!mounted) return;
      hideLoading();

      if (response?.status == true && response?.data != null) {
        FocusScope.of(context).unfocus();
        Navigator.pushNamed(
          context,
          RoutesNames.pendingRecharge,
          arguments: response!.data,
        );
      } else {
        showErrorMessage(response?.message);
      }
    } catch (_) {
      hideLoading();
      showErrorMessage(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currency = ref.watch(userLocalProvider)?.targetCurrency ?? '';
    final tr = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Palette.white,
      appBar: AppBar(
        backgroundColor: Palette.white,
        elevation: 0,
        leading: const RoundedCloseButton(),
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

                      MoneyAmountOperationBloc(
                        amount: widget.data.amount,
                        netAmount: widget.data.netAmount,
                        fee: widget.data.totalFee,
                        currency: currency, title: tr.recharge,
                      ),

                      const SizedBox(
                        height: 1,
                        child: ColoredBox(color: Color(0xFFF0F0F0)),
                      ),

                      const Gap(24),
                      RechargeInfoBlock(
                        phoneNumber: widget.data.phoneNumber,
                        country: widget.data.country,
                        operator: widget.data.operator,
                        tr: tr,
                      ),
                    ],
                  ),
                ),
              ),

              MoneyConfirmBottom(
                label: tr.confirmRecharge,
                onTap: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}





