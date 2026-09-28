import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:corrispay/app/design/palette.dart';
import 'package:corrispay/core/local/userlocal_provider.dart';
import 'package:corrispay/core/utils/functions.dart';
import 'package:corrispay/features/bases/services/service.dart';
import 'package:corrispay/features/bases/widgets/default_button.dart';
import 'package:corrispay/features/mobiles-transactions/responses/mobile_deposit_data.dart';
import 'package:corrispay/features/mobiles-transactions/widgets/transaction_amount_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../l10n/app_localizations.dart';
import '../widgets/receipt_list.dart';
import '../widgets/transaction_notice_text.dart';
import '../widgets/transaction_status_header.dart';

class PendingRechargeView extends ConsumerStatefulWidget {
  const PendingRechargeView({super.key, required this.data});
  final MobileDepositData data;

  @override
  ConsumerState<PendingRechargeView> createState() =>
      _PendingRechargeViewState();
}

class _PendingRechargeViewState extends ConsumerState<PendingRechargeView> {
  final SocketService _socketService = SocketService();
  String _status = 'PENDING';

  @override
  void initState() {
    super.initState();
    _initSocket();
  }

  Future<void> _initSocket() async {
    await _socketService.connect();
    _socketService.watchTransaction(widget.data.reference);
    _socketService.listenTransactionStatus((data) {
      if (!mounted) return;
      setState(() => _status = data['status']);

      if (_status == 'SUCCESS') {
        _socketService.unwatchTransaction(widget.data.reference);
      } else if (_status == 'FAILED') {
        _socketService.unwatchTransaction(widget.data.reference);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) showErrorMessage('Transaction echouee');
        });
      }
    });
  }

  @override
  void dispose() {
    _socketService.unwatchTransaction(widget.data.reference);
    _socketService.stopListeningTransactionStatus();
    super.dispose();
  }

  void _goHome() => Navigator.popUntil(context, (route) => route.isFirst);

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    final user = ref.watch(userLocalProvider)!;
    final currency = user.targetCurrency;
    final data = widget.data;
    final totalFees = data.providerFee + data.corisFee;
    final statusStyle = TransactionStatusStyle.of(_status);

    return Scaffold(
      backgroundColor: Palette.white,
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) _goHome();
        },
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(8),
                      GestureDetector(
                        onTap: _goHome,
                        child: const Icon(
                          Icons.arrow_back,
                          size: 18,
                          color: Palette.black,
                        ),
                      ),

                      const Gap(28),

                      TransactionStatusHeader(status: _status),
                      const Gap(20),

                      TransactionAmountHeader(
                        amount: data.netAmount,
                        currency: currency,
                        summary: tr.rechargeSummary(
                          data.amount,
                          currency,
                          data.operator,
                          data.phone,
                        ),
                      ),

                      const Gap(32),

                      ReceiptList(
                        rows: [
                          ReceiptRow(
                            label: tr.status,
                            value: statusStyle.label,
                            valueColor: statusStyle.color,
                          ),
                          ReceiptRow(label: tr.sentBy, value: data.phone),
                          ReceiptRow(label: tr.sentVia, value: data.operator),
                          ReceiptRow(
                            label: tr.amount,
                            value:
                            '${data.amount.toStringAsFixed(2)} $currency',
                          ),
                          ReceiptRow(
                            label: tr.fees,
                            value:
                            '${totalFees.toStringAsFixed(2)} $currency',
                          ),
                          ReceiptRow(label: tr.account, value: data.account),
                        ],
                      ),

                      const Gap(28),

                      if (_status == 'PENDING')
                        TransactionNoticeText(message: data.message),

                      const Gap(16),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DefaultButton(
                  text: tr.back_to_home,
                  bgColor: Palette.petrolBlue,
                  padding: 15,
                  textStyle: FontsStyles.medium.copyWith(
                    fontSize: 13.5,
                    color: Palette.white,
                  ),
                  onTap: _goHome,
                ),
              ),

              const Gap(24),
            ],
          ),
        ),
      ),
    );
  }
}