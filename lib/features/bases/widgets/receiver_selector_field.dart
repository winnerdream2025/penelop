import 'package:flutter/material.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';

/// Champ de sélection de destinataire réutilisable — affiche soit un
/// placeholder ("Qui ?"), soit la personne sélectionnée (initiales,
/// nom, numéro), avec chevron pour ouvrir le sélecteur.
///
/// Utilisation :
/// ```dart
/// ReceiverSelectorField(
///   title: selectedReceiver != null
///       ? '${selectedReceiver!.firstName} ${selectedReceiver!.lastName}'
///       : null,
///   subtitle: selectedReceiver?.phoneNumber,
///   initials: selectedReceiver != null
///       ? '${selectedReceiver!.firstName[0]}${selectedReceiver!.lastName[0]}'
///       : null,
///   placeholder: tr.toWho,
///   onTap: _pickReceiver,
/// )
/// ```
class ReceiverSelectorField extends StatelessWidget {
  const ReceiverSelectorField({
    super.key,
    required this.onTap,
    required this.placeholder,
    this.title,
    this.subtitle,
    this.initials,
  });

  /// Nom affiché une fois un destinataire choisi. `null` = rien sélectionné.
  final String? title;
  final String? subtitle;
  final String? initials;
  final String placeholder;
  final VoidCallback onTap;

  bool get _hasSelection => title != null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFEBEBEB), width: 0.5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: _hasSelection
                    ? Palette.petrolBlue
                    : Palette.petrolBlue.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: _hasSelection
                    ? Text(
                  initials ?? '',
                  style: FontsStyles.bold.copyWith(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                )
                    : Icon(
                  Icons.person_add_outlined,
                  size: 18,
                  color: Palette.petrolBlue,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _hasSelection
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    style: FontsStyles.medium.copyWith(
                      fontSize: 13.5,
                      color: const Color(0xFF0D0D0D),
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 1),
                    Text(
                      subtitle!,
                      style: FontsStyles.regular.copyWith(
                        fontSize: 11,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ],
              )
                  : Text(
                placeholder,
                style: FontsStyles.regular.copyWith(
                  fontSize: 14,
                  color: const Color(0xFFB0B8C1),
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              size: 18,
              color: Color(0xFF9CA3AF),
            ),
          ],
        ),
      ),
    );
  }
}