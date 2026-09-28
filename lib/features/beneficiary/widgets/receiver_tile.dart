import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:corrispay/app/design/palette.dart';
import 'package:corrispay/features/beneficiary/models/beneficiary.model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ReceiverTile extends StatelessWidget {
  const ReceiverTile({
    super.key,
    required this.receiver,
    required this.selectedReceiver,
    this.subtitleOverride,
    this.isContact = false,
  });

  final Beneficiary receiver;
  final Beneficiary? selectedReceiver;
  final bool? isContact;

  /// Si fourni (ex: "Dans vos contacts"), remplace l'affichage du numéro
  /// de téléphone — utilisé pour la section "Sur CaurisPay" où le numéro
  /// est déjà connu de l'utilisateur via son répertoire. Sert aussi de
  /// signal pour styliser l'avatar différemment (teinte ambre cohérente
  /// plutôt que la palette tournante des bénéficiaires enregistrés).
  final String? subtitleOverride;

  bool get _isSuggestedContact => subtitleOverride != null;

  bool get _isSelected =>
      selectedReceiver != null && selectedReceiver!.id == receiver.id;

  static const Color _suggestedAvatarBg = Color(0xFFFAEEDA);
  static const Color _suggestedAvatarFg = Color(0xFF854F0B);

  Color get _avatarBg {
    if (_isSuggestedContact) return _suggestedAvatarBg;
    final colors = [
      const Color(0xFFD6EEF0),
      const Color(0xFFFEF0E3),
      const Color(0xFFD5EFEE),
      const Color(0xFFFBF5E6),
      const Color(0xFFEDE9FC),
    ];
    return colors[receiver.firstName.codeUnitAt(0) % colors.length];
  }

  Color get _avatarFg {
    if (_isSuggestedContact) return _suggestedAvatarFg;
    final colors = [
      Palette.petrolBlue,
      Palette.orange,
      Palette.teal,
      Palette.goldYellow,
      const Color(0xFF5B4FCF),
    ];
    return colors[receiver.firstName.codeUnitAt(0) % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context, receiver),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.only(bottom: 2),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          // Fond pâle discret, juste pour guider l'œil — le vrai signal
          // de sélection est le cercle plein à droite, pas le fond.
          color: _isSelected
              ? Palette.petrolBlue.withOpacity(0.06)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: _avatarBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  isContact == true
                      ? receiver.savedAs != null
                            ? receiver.savedAs!.substring(0, 1)
                            : receiver.firstName[0]
                      : '${receiver.firstName[0]}${receiver.lastName[0]}',
                  style: FontsStyles.bold.copyWith(
                    fontSize: 13,
                    color: _avatarFg,
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
                    receiver.savedAs != null
                        ? receiver.savedAs!
                        : '${receiver.firstName} ${receiver.lastName}',
                    style: FontsStyles.bold.copyWith(
                      fontSize: 13,
                      color: Palette.black,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    subtitleOverride ?? receiver.phoneNumber,
                    style: FontsStyles.regular.copyWith(
                      fontSize: 11,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _isSelected ? Palette.petrolBlue : Colors.transparent,
                border: Border.all(
                  color: _isSelected
                      ? Palette.petrolBlue
                      : const Color(0xFFE0E0E0),
                  width: 1.5,
                ),
              ),
              child: _isSelected
                  ? const Icon(
                      Icons.check_rounded,
                      size: 13,
                      color: Palette.white,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
