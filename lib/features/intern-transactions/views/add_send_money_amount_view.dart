import 'package:corrispay/app/routes/routes_names.dart';
import 'package:corrispay/features/transactions/dto/create_intern_transaction.dto.dart';
import 'package:corrispay/features/transactions/providers/transactions_providers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../../../core/local/userlocal_provider.dart';
import '../../../core/local/business_settings_local_provider.dart';
import '../../../core/utils/functions.dart';
import '../../../l10n/app_localizations.dart';
import '../../bases/screens/transaction_summay_card.dart';
import '../../bases/widgets/default_button.dart';
import '../../bases/widgets/amount_input_field.dart';
import '../../bases/widgets/receiver_selector_field.dart';
import '../../beneficiary/models/beneficiary.model.dart';

class AddSendMoneyAmountView extends ConsumerStatefulWidget {
  const AddSendMoneyAmountView({super.key, required this.balance});

  final double balance;

  @override
  ConsumerState<AddSendMoneyAmountView> createState() =>
      _AddSendMoneyAmountViewState();
}

class _AddSendMoneyAmountViewState
    extends ConsumerState<AddSendMoneyAmountView> {
  final TextEditingController _amountController = TextEditingController();

  Beneficiary? selectedReceiver;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  double get _enteredAmount => double.tryParse(_amountController.text) ?? 0;

  double get _transferFee =>
      ref.read(businessSettingsLocalProvider)?.caurisTransferFees ?? 0;

  double get _minTransferAmount =>
      ref.read(businessSettingsLocalProvider)?.minTransferAmount ?? 0;

  double get _totalDebited =>
      _enteredAmount == 0 ? 0 : _enteredAmount * (1 + _transferFee);

  double get _remainingBalance => widget.balance - _totalDebited;

  bool get _isBelowMinimum =>
      _enteredAmount > 0 && _enteredAmount < _minTransferAmount;

  bool get _isInsufficientBalance =>
      _enteredAmount > 0 && _totalDebited > widget.balance;

  bool get _hasError => _isBelowMinimum || _isInsufficientBalance;

  String? get _errorMessage {
    if (_isBelowMinimum) {
      return 'Le montant minimum est de ${_formatAmount(_minTransferAmount)} FCFA';
    }
    if (_isInsufficientBalance) {
      final missing = _totalDebited - widget.balance;
      return 'Dépasse votre solde de ${_formatAmount(missing)} FCFA';
    }
    return null;
  }

  String _formatAmount(double value) {
    return value
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]} ',
        );
  }

  bool get _isFormValid =>
      _enteredAmount > 0 &&
      !_isBelowMinimum &&
      !_isInsufficientBalance &&
      selectedReceiver != null;

  Future<void> _pickReceiver() async {
    final receiver = await Navigator.pushNamed(
      context,
      RoutesNames.receiverChoice,
      arguments: selectedReceiver,
    );
    if (receiver != null) {
      setState(() => selectedReceiver = receiver as Beneficiary?);
    }
  }

  Future<void> submitForm() async {
    showLoading();

    final response = await ref.read(
      createInternTransactionProvider(
        CreateInternTransactionDto(
          amount: _enteredAmount,
          to: selectedReceiver!.id,
        ),
      ).future,
    );

    hideLoading();

    if (!mounted) return;

    if (response != null && response.status && response.data != null) {
      Navigator.pushNamed(
        context,
        RoutesNames.confirmSendMoney,
        arguments: response.data,
      );
    } else {
      showErrorMessage(response?.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    final user = ref.watch(userLocalProvider);
    final currency = user?.targetCurrency ?? 'FCFA';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 22, 24, 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFF5F5F5),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 17,
                        color: Color(0xFF0D0D0D),
                      ),
                    ),
                  ),
                  const Gap(14),
                  Expanded(
                    child: Text(
                      tr.sendMoney,
                      style: FontsStyles.bold.copyWith(
                        fontSize: 20,
                        color: const Color(0xFF0D0D0D),
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 16,
                        height: 3,
                        decoration: BoxDecoration(
                          color: Palette.petrolBlue,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const Gap(4),
                      Container(
                        width: 16,
                        height: 3,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5E5E5),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr.amount.toUpperCase(),
                      style: FontsStyles.bold.copyWith(
                        fontSize: 11,
                        color: const Color(0xFF9CA3AF),
                        letterSpacing: 1.6,
                      ),
                    ),
                    const Gap(8),

                    AmountInputField(
                      controller: _amountController,
                      currency: currency,
                      minAmount: _minTransferAmount,
                      hasError: _hasError,
                      autofocus: true,
                      onChanged: (_) => setState(() {}),
                    ),

                    if (_hasError) ...[
                      const Gap(8),
                      Row(
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 14,
                            color: Color(0xFFA32D2D),
                          ),
                          const Gap(6),
                          Expanded(
                            child: Text(
                              _errorMessage!,
                              style: FontsStyles.medium.copyWith(
                                fontSize: 11.5,
                                color: const Color(0xFFA32D2D),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],

                    if (_enteredAmount > 0 && !_hasError) ...[
                      const Gap(20),
                      TransactionSummaryCard(
                        items: [
                          SummaryItem(
                            icon: Icons.account_balance_wallet_outlined,
                            label: 'Solde disponible',
                            value: '${_formatAmount(widget.balance)} $currency',
                          ),
                          /**
                           *  SummaryItem(
                              icon: Icons.percent,
                              label: 'Frais CaurisPay',
                              value: '${_formatAmount(_transferFee)} $currency',
                              ),
                              SummaryItem(
                              icon: Icons.receipt_long_outlined,
                              label: 'Total débité',
                              value: '${_formatAmount(_totalDebited)} $currency',
                              ),
                           */
                          SummaryItem(
                            icon: Icons.check_circle_outline,
                            label: 'Solde après envoi',
                            value:
                                '${_formatAmount(_remainingBalance < 0 ? 0 : _remainingBalance)} $currency',
                            highlighted: true,
                          ),
                        ],
                      ),
                    ],

                    const Gap(22),

                    Text(
                      tr.recipient.toUpperCase(),
                      style: FontsStyles.bold.copyWith(
                        fontSize: 11,
                        color: const Color(0xFF9CA3AF),
                        letterSpacing: 1.6,
                      ),
                    ),
                    const Gap(8),
                    ReceiverSelectorField(
                      onTap: _pickReceiver,
                      placeholder: tr.toWho,
                      title: selectedReceiver != null
                          ? selectedReceiver?.savedAs ??
                                '${selectedReceiver!.firstName} ${selectedReceiver!.lastName}'
                          : null,
                      subtitle: selectedReceiver?.phoneNumber,
                      initials: selectedReceiver != null
                          ? '${selectedReceiver!.firstName[0]}${selectedReceiver!.lastName[0]}'
                          : null,
                    ),

                    const Gap(24),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: DefaultButton(
                isEnable: _isFormValid,
                onTap: _isFormValid ? submitForm : null,
                text: tr.next,
                padding: 16,
                textStyle: FontsStyles.medium.copyWith(
                  fontSize: 15,
                  color: Palette.white,
                ),
              ),
            ),
            Gap(32),
          ],
        ),
      ),
    );
  }
}
