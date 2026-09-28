import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:corrispay/app/design/palette.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../l10n/app_localizations.dart';

/// Carte "Expéditeur" — volontairement sobre (bordure fine, icône neutre)
/// car l'utilisateur connaît déjà sa propre identité. Sert juste de
/// confirmation visuelle du compte source, sans attirer l'attention
/// autant que le destinataire.
class SenderInfoBloc extends StatelessWidget {
  const SenderInfoBloc({super.key, required this.accountNumber});

  final String accountNumber;

  /// Formate en groupes de 2 chiffres pour la lisibilité,
  /// ex: "22898163825" -> "228 98 16 38 25".
  String _formatAccountNumber(String raw) {
    final digits = raw.replaceAll(RegExp(r'\D'), '');
    if (digits.length <= 3) return digits;

    final buffer = StringBuffer(digits.substring(0, 3));
    for (var i = 3; i < digits.length; i += 2) {
      final end = (i + 2 > digits.length) ? digits.length : i + 2;
      buffer.write(' ${digits.substring(i, end)}');
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            tr.sender.toUpperCase(),
            style: FontsStyles.bold.copyWith(
              fontSize: 11,
              color: const Color(0xFFB0B0B0),
              letterSpacing: 0.8,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFEBEBEB), width: 0.5),
          ),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.person_outline_rounded,
                  size: 17,
                  color: Color(0xFF8A8A8A),
                ),
              ),
              const Gap(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr.accountNumber,
                    style: FontsStyles.regular.copyWith(
                      fontSize: 12.5,
                      color: const Color(0xFF8A8A8A),
                    ),
                  ),
                  const Gap(2),
                  Text(
                    _formatAccountNumber(accountNumber),
                    style: FontsStyles.bold.copyWith(
                      fontSize: 13,
                      color: Palette.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}