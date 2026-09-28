import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:corrispay/app/design/palette.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../l10n/app_localizations.dart';

/// Carte "Destinataire" — volontairement mise en avant (bordure marquée,
/// avatar coloré) puisque c'est l'info la plus importante à vérifier
/// avant de confirmer un transfert.
class RecipientInfoBloc extends StatelessWidget {
  const RecipientInfoBloc({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.accountNumber,
    required this.amount,
    required this.currency,
  });

  final String firstName;
  final String lastName;
  final String accountNumber;
  final double amount;
  final String currency;

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

  String get _initials {
    final f = firstName.isNotEmpty ? firstName[0] : '';
    final l = lastName.isNotEmpty ? lastName[0] : '';
    return '$f$l'.toUpperCase();
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
            tr.recipient.toUpperCase(),
            style: FontsStyles.bold.copyWith(
              fontSize: 11,
              color: Palette.orange,
              letterSpacing: 0.8,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Palette.petrolBlue, width: 1.5),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Palette.petrolBlue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        _initials,
                        style: FontsStyles.bold.copyWith(
                          fontSize: 14,
                          color: Palette.white,
                        ),
                      ),
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$firstName $lastName',
                          style: FontsStyles.bold.copyWith(
                            fontSize: 14,
                            color: Palette.black,
                          ),
                        ),
                        const Gap(2),
                        Text(
                          _formatAccountNumber(accountNumber),
                          style: FontsStyles.regular.copyWith(
                            fontSize: 11.5,
                            color: const Color(0xFF8A8A8A),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(14),
              const Divider(height: 0.5, color: Color(0xFFEFEFEF)),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tr.amount_to_be_received,
                    style: FontsStyles.regular.copyWith(
                      fontSize: 12,
                      color: const Color(0xFF8A8A8A),
                    ),
                  ),
                  Text(
                    '${amount.toStringAsFixed(0)} $currency',
                    style: FontsStyles.bold.copyWith(
                      fontSize: 14,
                      color: Palette.petrolBlue,
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