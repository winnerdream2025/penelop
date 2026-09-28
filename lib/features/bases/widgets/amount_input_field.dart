import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';

/// Champ de saisie de montant réutilisable — cadre blanc, badge devise,
/// et indication du montant minimum en dessous.
///
/// Utilisation :
/// ```dart
/// AmountInputField(
///   controller: _amountController,
///   currency: user.targetCurrency,
///   minAmount: 500,
///   hasError: _isBelowMinimum || _isInsufficientBalance,
///   onChanged: (_) => setState(() {}),
/// )
/// ```
class AmountInputField extends StatelessWidget {
  const AmountInputField({
    super.key,
    required this.controller,
    required this.currency,
    this.minAmount,
    this.hasError = false,
    this.onChanged,
    this.autofocus = false,
  });

  final TextEditingController controller;
  final String currency;
  final double? minAmount;
  final bool hasError;
  final ValueChanged<String>? onChanged;
  final bool autofocus;

  String _formatAmount(double value) {
    return value
        .toStringAsFixed(0)
        .replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]} ',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: hasError
                  ? const Color(0xFFE24B4A)
                  : const Color(0xFFEBEBEB),
              width: 1.5,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: IntrinsicWidth(
                    child: TextField(
                      controller: controller,
                      autofocus: autofocus,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      textAlign: TextAlign.left,
                      cursorColor: Palette.petrolBlue,
                      cursorHeight: 34,
                      style: FontsStyles.bold.copyWith(
                        fontSize: 38,
                        color: const Color(0xFF0D0D0D),
                        letterSpacing: -1,
                        height: 1,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '0',
                        hintStyle: FontsStyles.bold.copyWith(
                          fontSize: 38,
                          color: const Color(0xFFDEDEDE),
                          letterSpacing: -1,
                          height: 1,
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      onChanged: onChanged,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Palette.petrolBlue.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  currency,
                  style: FontsStyles.bold.copyWith(
                    fontSize: 12,
                    color: Palette.petrolBlue,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (minAmount != null) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              'Montant minimum ${_formatAmount(minAmount!)} $currency',
              style: FontsStyles.bold.copyWith(
                fontSize: 11,
                color: Palette.teal,
              ),
            ),
          ),
        ],
      ],
    );
  }
}