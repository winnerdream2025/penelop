import 'package:flutter/material.dart';
import '../../../app/design/fonts_styles.dart';

/// Une ligne du récapitulatif (icône + label à gauche, valeur à droite).
class SummaryItem {
  const SummaryItem({
    required this.icon,
    required this.label,
    required this.value,
    this.highlighted = false,
  });

  final IconData icon;
  final String label;
  final String value;

  /// Met en avant la ligne (fond teinté + texte en couleur) —
  /// typiquement pour "Solde après envoi".
  final bool highlighted;
}

/// Carte récapitulative façon "reçu" — réutilisable pour transfert,
/// retrait, recharge, ou tout écran ayant besoin d'un résumé de frais.
///
/// Utilisation :
/// ```dart
/// TransactionSummaryCard(
///   items: [
///     SummaryItem(icon: Icons.account_balance_wallet_outlined, label: 'Solde disponible', value: '125 400 FCFA'),
///     SummaryItem(icon: Icons.percent, label: 'Frais CaurisPay', value: '500 FCFA'),
///     SummaryItem(icon: Icons.receipt_long_outlined, label: 'Total débité', value: '50 500 FCFA'),
///     SummaryItem(icon: Icons.check_circle_outline, label: 'Solde après envoi', value: '74 900 FCFA', highlighted: true),
///   ],
/// )
/// ```
class TransactionSummaryCard extends StatelessWidget {
  const TransactionSummaryCard({super.key, required this.items});

  final List<SummaryItem> items;

  static const Color _highlightBg = Color(0xFFF7FAF9);
  static const Color _highlightColor = Color(0xFF0F6E56);
  static const Color _borderColor = Color(0xFFEBEBEB);
  static const Color _dividerColor = Color(0xFFF2F2F2);
  static const Color _labelColor = Color(0xFF6B7280);
  static const Color _valueColor = Color(0xFF0D0D0D);
  static const Color _iconColor = Color(0xFF9CA3AF);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor, width: 0.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          for (var i = 0; i < items.length; i++)
            _SummaryRow(
              item: items[i],
              showDivider: i != items.length - 1,
            ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.item, required this.showDivider});

  final SummaryItem item;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final labelColor = item.highlighted
        ? TransactionSummaryCard._highlightColor
        : TransactionSummaryCard._labelColor;
    final valueColor = item.highlighted
        ? TransactionSummaryCard._highlightColor
        : TransactionSummaryCard._valueColor;

    return Container(
      decoration: BoxDecoration(
        color: item.highlighted
            ? TransactionSummaryCard._highlightBg
            : Colors.transparent,
        border: showDivider
            ? const Border(
          bottom: BorderSide(
            color: TransactionSummaryCard._dividerColor,
            width: 0.5,
          ),
        )
            : null,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                item.icon,
                size: 15,
                color: item.highlighted
                    ? TransactionSummaryCard._highlightColor
                    : TransactionSummaryCard._iconColor,
              ),
              const SizedBox(width: 8),
              Text(
                item.label,
                style: (item.highlighted
                    ? FontsStyles.medium
                    : FontsStyles.regular)
                    .copyWith(fontSize: 12.5, color: labelColor),
              ),
            ],
          ),
          Text(
            item.value,
            style: (item.highlighted ? FontsStyles.bold : FontsStyles.medium)
                .copyWith(
              fontSize: item.highlighted ? 13 : 12.5,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}