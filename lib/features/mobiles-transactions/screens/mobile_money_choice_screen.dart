import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:corrispay/app/design/palette.dart';
import 'package:corrispay/features/transactions/models/country_operator_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MobileMoneyChoiceScreen extends StatelessWidget {
  const MobileMoneyChoiceScreen({
    super.key,
    required this.selectedMobileMoney,
    required this.updateSelectedMobileMoney,
    required this.mobilesMoneys,
    required this.countryName,
    required this.countryFlag,
  });

  final Operator selectedMobileMoney;
  final Function(Operator mobileMoney) updateSelectedMobileMoney;
  final List<Operator> mobilesMoneys;
  final String countryName;
  final String countryFlag;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF8F8F8),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top+60
      ),
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).padding.bottom + 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top row — close + country pill
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _CloseButton(onTap: () => Navigator.pop(context)),
              _CountryPill(flag: countryFlag, name: countryName),
            ],
          ),

          const Gap(28),

          /// Title
          Text(
            "Choisir l'opérateur",
            style: FontsStyles.bold.copyWith(
              fontSize: 22,
              color: Palette.black,
              letterSpacing: -0.4,
            ),
          ),

          const Gap(16),

          /// List
          Expanded(
            child: ListView.separated(
              itemCount: mobilesMoneys.length,
              separatorBuilder: (_, __) => const Gap(10),
              itemBuilder: (context, index) {
                final op = mobilesMoneys[index];
                final isSelected = selectedMobileMoney == op;
                return _OperatorItem(
                  operator: op,
                  isSelected: isSelected,
                  onTap: () {
                    updateSelectedMobileMoney(op);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── Close button ──────────────────────────────────────────────────────────────

class _CloseButton extends StatelessWidget {
  const _CloseButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: const BoxDecoration(
          color: Color(0xFFEFEFEF),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.close, size: 16, color: Palette.black),
      ),
    );
  }
}

// ── Country pill ──────────────────────────────────────────────────────────────

class _CountryPill extends StatelessWidget {
  const _CountryPill({required this.flag, required this.name});
  final String flag;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 14, 8),
      decoration: BoxDecoration(
        color: Palette.white,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: const Color(0xFFEBEBEB)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: Color(0xFFE8F4F5),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(flag, style: const TextStyle(fontSize: 16)),
            ),
          ),
          const Gap(8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'PAYS',
                style: FontsStyles.medium.copyWith(
                  fontSize: 10,
                  color: const Color(0xFFBBBBBB),
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                name,
                style: FontsStyles.bold.copyWith(
                  fontSize: 13,
                  color: Palette.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Operator item ─────────────────────────────────────────────────────────────

class _OperatorItem extends StatelessWidget {
  const _OperatorItem({
    required this.operator,
    required this.isSelected,
    required this.onTap,
  });

  final Operator operator;
  final bool isSelected;
  final VoidCallback onTap;

  /// Génère une couleur d'avatar basée sur le label de l'opérateur
  Color get _avatarBg {
    final colors = [
      const Color(0xFFFFF0E6),
      const Color(0xFFE6F7FF),
      const Color(0xFFF3EEF9),
      const Color(0xFFE0F0F1),
      const Color(0xFFFEF9E6),
    ];
    return colors[operator.label.hashCode.abs() % colors.length];
  }

  Color get _avatarFg {
    final colors = [
      Palette.orange,
      const Color(0xFF0288D1),
      const Color(0xFF7B52AE),
      Palette.petrolBlue,
      Palette.goldYellow,
    ];
    return colors[operator.label.hashCode.abs() % colors.length];
  }

  String get _initials {
    final words = operator.label.trim().split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return operator.label.substring(0, 2).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Palette.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? Palette.petrolBlue : const Color(0xFFF0F0F0),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            /// Avatar
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _avatarBg,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  _initials,
                  style: FontsStyles.bold.copyWith(
                    fontSize: 13,
                    color: _avatarFg,
                  ),
                ),
              ),
            ),

            const Gap(14),

            /// Name
            Expanded(
              child: Text(
                operator.label,
                style: FontsStyles.medium.copyWith(
                  fontSize: 15,
                  color: Palette.black,
                ),
              ),
            ),

            /// Radio indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Palette.petrolBlue : Colors.transparent,
                border: Border.all(
                  color: isSelected ? Palette.petrolBlue : const Color(0xFFE0E0E0),
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 14, color: Palette.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}