import 'package:flutter/material.dart';
import '../../../app/design/fonts_styles.dart';

/// Montant en gros, centré, avec une ligne de résumé discrète en
/// dessous (ex: "Recharge via Moov Money · 228 90 12 34 56").
class TransactionAmountHeader extends StatelessWidget {
  const TransactionAmountHeader({
    super.key,
    required this.amount,
    required this.currency,
    required this.summary,
  });

  final double amount;
  final String currency;
  final String summary;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            text: amount.toStringAsFixed(0),
            style: FontsStyles.bold.copyWith(
              fontSize: 44,
              color: const Color(0xFF131313),
              letterSpacing: -1.5,
              fontWeight: FontWeight.w600,
            ),
            children: [
              TextSpan(
                text: ' $currency',
                style: FontsStyles.medium.copyWith(
                  fontSize: 18,
                  color: const Color(0xFF9CA3AF),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          summary,
          textAlign: TextAlign.center,
          style: FontsStyles.regular.copyWith(
            fontSize: 12.5,
            color: const Color(0xFF9CA3AF),
          ),
        ),
      ],
    );
  }
}