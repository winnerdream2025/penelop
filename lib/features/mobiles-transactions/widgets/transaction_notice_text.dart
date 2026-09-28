import 'package:flutter/material.dart';
import '../../../app/design/fonts_styles.dart';

/// Notice discrète (icône + texte gris) — plus de bloc coloré plein,
/// pour rester dans le registre sobre du reçu.
class TransactionNoticeText extends StatelessWidget {
  const TransactionNoticeText({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.info_outline_rounded,
          size: 14,
          color: Color(0xFF9CA3AF),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            message,
            style: FontsStyles.regular.copyWith(
              fontSize: 11.5,
              color: const Color(0xFF9CA3AF),
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}