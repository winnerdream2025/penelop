import 'package:flutter/material.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../../transactions/models/country_operator_model.dart';

/// Champ compact affichant l'opérateur sélectionné — tap pour ouvrir
/// le bottom sheet de choix (voir [showOperatorPicker]). [selected]
/// peut être `null` (aucun choix encore fait).
class OperatorSelectorField extends StatelessWidget {
  const OperatorSelectorField({
    super.key,
    required this.selected,
    required this.onTap,
  });

  final Operator? selected;
  final VoidCallback onTap;

  bool get _hasSelection => selected != null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: _hasSelection ? Palette.petrolBlue : const Color(0xFFEBEBEB),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: _hasSelection
            ? Row(
          children: [
            _OperatorLogo(operator: selected!, size: 38),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                selected!.label,
                style: FontsStyles.bold.copyWith(
                  fontSize: 13.5,
                  color: Palette.black,
                ),
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 20,
              color: Color(0xFF9CA3AF),
            ),
          ],
        )
            : Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(9),
              ),
              child: const Icon(
                Icons.device_hub_rounded,
                size: 15,
                color: Color(0xFF9CA3AF),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Choisir un reseau',
                style: FontsStyles.regular.copyWith(
                  fontSize: 13.5,
                  color: const Color(0xFFB0B8C1),
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: Color(0xFF9CA3AF),
            ),
          ],
        ),
      ),
    );
  }
}

/// Ouvre le bottom sheet de choix de l'opérateur. Renvoie l'opérateur
/// choisi via `Navigator.pop(context, operator)`, ou `null` si annulé.
Future<Operator?> showOperatorPicker({
  required BuildContext context,
  required List<Operator> operators,
  Operator? selected,
  required String countryLabel,
}) {
  return showModalBottomSheet<Operator>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => _OperatorBottomSheet(
      operators: operators,
      selected: selected,
      countryLabel: countryLabel,
    ),
  );
}

class _OperatorBottomSheet extends StatelessWidget {
  const _OperatorBottomSheet({
    required this.operators,
    this.selected,
    required this.countryLabel,
  });

  final List<Operator> operators;
  final Operator? selected;
  final String countryLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Palette.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        18,
        16,
        18,
        MediaQuery.of(context).padding.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFEBEBEB),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Choisir un reseau',
            style: FontsStyles.bold.copyWith(fontSize: 17),
          ),
          const SizedBox(height: 4),
          Text(
            'Disponibles pour le $countryLabel',
            style: FontsStyles.regular.copyWith(
              fontSize: 12,
              color: const Color(0xFF9CA3AF),
            ),
          ),
          const SizedBox(height: 20),
          for (final op in operators) ...[
            _OperatorRow(
              operator: op,
              isSelected: selected != null && op.key == selected!.key,
              onTap: () => Navigator.pop(context, op),
            ),
            if (op != operators.last) const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

class _OperatorRow extends StatelessWidget {
  const _OperatorRow({
    required this.operator,
    required this.isSelected,
    required this.onTap,
  });

  final Operator operator;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Palette.petrolBlue : const Color(0xFFEBEBEB),
            width: isSelected ? 2 : 1.5,
          ),
        ),
        child: Row(
          children: [
            _OperatorLogo(operator: operator, size: 42),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    operator.label,
                    style: FontsStyles.bold.copyWith(
                      fontSize: 13.5,
                      color: Palette.black,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    'Frais : ${_formatFeePercent(operator.totalPayoutFees)}',
                    style: FontsStyles.regular.copyWith(
                      fontSize: 11,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 22,
                height: 22,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Palette.petrolBlue,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  size: 13,
                  color: Colors.white,
                ),
              )
            else
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFE0E0E0), width: 1.5),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Formate un taux décimal (ex: 0.0155) en pourcentage lisible ("1.55%").
String _formatFeePercent(double rate) {
  final percent = rate * 100;
  // Évite les décimales inutiles (1.50% -> 1.5%) tout en gardant la
  // précision quand elle compte (1.55% reste 1.55%).
  final formatted = percent.toStringAsFixed(2);
  final trimmed = formatted.endsWith('0')
      ? formatted.substring(0, formatted.length - 1)
      : formatted;
  return '${trimmed.endsWith('.') ? trimmed.substring(0, trimmed.length - 1) : trimmed}%';
}

/// Logo réel de l'opérateur, chargé depuis [Operator.url]. Si le
/// chargement échoue (URL cassée, pas de réseau), retombe sur un badge
/// avec les premières lettres du nom plutôt que de casser l'affichage.
class _OperatorLogo extends StatelessWidget {
  const _OperatorLogo({required this.operator, required this.size});

  final Operator operator;
  final double size;

  Color get _fallbackColor {
    final colors = [
      const Color(0xFFFF8A00),
      const Color(0xFFFFD200),
      const Color(0xFF0F6E56),
      const Color(0xFF5B4FCF),
    ];
    return colors[operator.label.codeUnitAt(0) % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.28),
        color: Colors.white,
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.all(size * 0.12),
        child: Image.network(
          operator.url,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return Center(
              child: SizedBox(
                width: size * 0.35,
                height: size * 0.35,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Palette.petrolBlue,
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) => Container(
            decoration: BoxDecoration(
              color: _fallbackColor,
              borderRadius: BorderRadius.circular(size * 0.28),
            ),
            child: Center(
              child: Text(
                operator.label.length > 4
                    ? operator.label.substring(0, 4)
                    : operator.label,
                style: FontsStyles.bold.copyWith(
                  fontSize: size * 0.24,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}