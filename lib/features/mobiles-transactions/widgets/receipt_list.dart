import 'package:flutter/material.dart';
import '../../../app/design/fonts_styles.dart';

/// Une ligne du reçu — label à gauche, valeur à droite (texte ou
/// widget custom via [child], ex: pour une couleur de statut).
class ReceiptRow {
  const ReceiptRow({
    required this.label,
    this.value,
    this.valueColor,
    this.child,
  }) : assert(value != null || child != null);

  final String label;
  final String? value;
  final Color? valueColor;
  final Widget? child;
}

/// Liste façon reçu — juste des séparateurs fins entre les lignes,
/// pas de carte bordée. Réutilisable pour n'importe quel type de
/// transaction (recharge, retrait, transfert...).
class ReceiptList extends StatelessWidget {
  const ReceiptList({super.key, required this.rows});

  final List<ReceiptRow> rows;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < rows.length; i++)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 13),
            decoration: BoxDecoration(
              border: i != rows.length - 1
                  ? const Border(
                bottom: BorderSide(
                  color: Color(0xFFEFEFEF),
                  width: 0.5,
                ),
              )
                  : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  rows[i].label,
                  style: FontsStyles.regular.copyWith(
                    fontSize: 12.5,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
                rows[i].child ??
                    Text(
                      rows[i].value!,
                      style: FontsStyles.medium.copyWith(
                        fontSize: 12.5,
                        color: rows[i].valueColor ?? const Color(0xFF131313),
                      ),
                    ),
              ],
            ),
          ),
      ],
    );
  }
}