import 'package:corrispay/core/utils/functions.dart';
import 'package:corrispay/features/bases/widgets/rounded_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../../../app/routes/routes_names.dart';
import '../../../core/local/userlocal_provider.dart';
import '../../../core/local/business_settings_local_provider.dart';
import '../../../core/utils/types.dart';
import '../../../l10n/app_localizations.dart';
import 'package:corrispay/features/bases/widgets/default_button.dart';
import 'package:corrispay/features/bases/widgets/amount_input_field.dart';
import '../../bases/screens/transaction_summay_card.dart';
import '../../transactions/providers/transactions_providers.dart';

class EnterWithdrawalAmountView extends ConsumerStatefulWidget {
  const EnterWithdrawalAmountView({super.key, required this.balance});
  final double balance;

  @override
  ConsumerState<EnterWithdrawalAmountView> createState() =>
      _EnterWithdrawalAmountViewState();
}

class _EnterWithdrawalAmountViewState
    extends ConsumerState<EnterWithdrawalAmountView> {
  final TextEditingController _amountController = TextEditingController();

  double get _enteredAmount => double.tryParse(_amountController.text) ?? 0;

  double get _minWithdrawalAmount =>
      ref.read(businessSettingsLocalProvider)?.minWithdrawalAmount ?? 0;

  double get _remainingBalance => widget.balance - _enteredAmount;

  bool get _isBelowMinimum =>
      _enteredAmount > 0 && _enteredAmount < _minWithdrawalAmount;

  bool get _isInsufficientBalance =>
      _enteredAmount > 0 && _enteredAmount > widget.balance;

  bool get _hasError => _isBelowMinimum || _isInsufficientBalance;

  String? _errorMessage(AppLocalizations loc) {
    if (_isBelowMinimum) {
      return 'Le montant minimum est de ${_formatAmount(_minWithdrawalAmount)} FCFA';
    }
    if (_isInsufficientBalance) {
      final missing = _enteredAmount - widget.balance;
      return 'Dépasse votre solde de ${_formatAmount(missing)} FCFA';
    }
    return null;
  }

  String _formatAmount(double value) {
    return value.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]} ',
    );
  }

  bool get _isFormValid =>
      _enteredAmount > 0 && !_isBelowMinimum && !_isInsufficientBalance;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final user = ref.watch(userLocalProvider);
    final currency = user?.targetCurrency ?? loc.currency;

    return Scaffold(
      backgroundColor: Palette.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const RoundedBackButton(),
                    const Gap(8),
                    Text(
                      loc.which_amount,
                      style: FontsStyles.bold.copyWith(fontSize: 20),
                    ),
                    const Gap(4),
                    Text(
                      loc.enterWithdrawalAmount,
                      style: FontsStyles.regular.copyWith(
                        fontSize: 13,
                        color: Colors.grey.shade500,
                      ),
                    ),

                    const Gap(28),

                    Text(
                      loc.amount.toUpperCase(),
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
                      minAmount: _minWithdrawalAmount,
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
                              _errorMessage(loc)!,
                              style: FontsStyles.medium.copyWith(
                                fontSize: 11.5,
                                color: const Color(0xFFA32D2D),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],

                    /**
                     * if (_enteredAmount > 0) ...[
                        const Gap(20),


                        TransactionSummaryCard(
                        items: [
                        SummaryItem(
                        icon: Icons.account_balance_wallet_outlined,
                        label: 'Solde disponible',
                        value:
                        '${_formatAmount(widget.balance)} $currency',
                        ),
                        SummaryItem(
                        icon: Icons.check_circle_outline,
                        label: 'Solde après retrait',
                        value:
                        '${_formatAmount(_remainingBalance < 0 ? 0 : _remainingBalance)} $currency',
                        highlighted: true,
                        ),
                        ],
                        ),
                        ],
                     */

                    const Gap(24),
                  ],
                ),
              ),
            ),

            // ── Bouton continuer
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: DefaultButton(
                isEnable: _isFormValid,
                text: loc.next,
                padding: 14,
                textStyle: FontsStyles.medium.copyWith(
                  fontSize: 15,
                  color: Palette.white,
                ),
                onTap: _isFormValid
                    ? () async {
                  showLoading();

                  final countriesResponse = await ref.read(
                    getCountriesWithMobileMoneyProvider(
                      OperationType.WITHDRAWAL,
                    ).future,
                  );

                  hideLoading();

                  if (!mounted) return;

                  if (countriesResponse != null) {
                    Navigator.pushNamed(
                      context,
                      RoutesNames.enterWithdrawalPhoneNumber,
                      arguments: (_enteredAmount, countriesResponse),
                    );
                  } else {
                    showErrorMessage(null);
                  }
                }
                    : null,
              ),
            ),
            Gap(32)
          ],
        ),
      ),
    );
  }
}