import 'package:flutter/material.dart';
import '../../../app/design/fonts_styles.dart';

/// Couleurs et libellés associés à chaque statut de transaction —
/// centralisé ici pour rester cohérent partout où un statut est affiché
/// (recharge, retrait, transfert...).
class TransactionStatusStyle {
  const TransactionStatusStyle({
    required this.color,
    required this.label,
  });

  final Color color;
  final String label;

  static TransactionStatusStyle of(String status) {
    switch (status) {
      case 'SUCCESS':
        return const TransactionStatusStyle(
          color: Color(0xFF0F6E56),
          label: 'Reussie',
        );
      case 'FAILED':
        return const TransactionStatusStyle(
          color: Color(0xFFA32D2D),
          label: 'Echouee',
        );
      case 'PENDING':
      default:
        return const TransactionStatusStyle(
          color: Color(0xFFD85A30),
          label: 'En attente de validation',
        );
    }
  }
}

/// En-tête minimal indiquant le statut — spinner discret pour PENDING,
/// icône check/croix pour SUCCESS/FAILED, avec le libellé en majuscules
/// à côté. Volontairement sobre (pas de badge/pilule coloré).
class TransactionStatusHeader extends StatelessWidget {
  const TransactionStatusHeader({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final style = TransactionStatusStyle.of(status);

    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIcon(style.color),
          const SizedBox(width: 6),
          Text(
            style.label.toUpperCase(),
            style: FontsStyles.medium.copyWith(
              fontSize: 11,
              color: const Color(0xFF9CA3AF),
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(Color color) {
    switch (status) {
      case 'SUCCESS':
        return Icon(Icons.check_circle_rounded, size: 15, color: color);
      case 'FAILED':
        return Icon(Icons.cancel_rounded, size: 15, color: color);
      case 'PENDING':
      default:
        return SizedBox(
          width: 14,
          height: 14,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: color,
            backgroundColor: const Color(0xFFE5E5E5),
          ),
        );
    }
  }
}