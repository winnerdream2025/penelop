import 'package:flutter/material.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../../transactions/models/country_operator_model.dart';

/// Champ compact affichant le pays sélectionné — tap pour ouvrir le
/// bottom sheet de choix (voir [showCountryPicker]). [selected] peut
/// être `null` (aucun choix encore fait), auquel cas un état vide
/// invite l'utilisateur à sélectionner un pays.
class CountrySelectorField extends StatelessWidget {
  const CountrySelectorField({
    super.key,
    required this.selected,
    required this.onTap,
  });

  final CountryOperatorModel? selected;
  final VoidCallback onTap;

  bool get _hasSelection => selected != null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
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
            Text(
              _flagEmoji(selected!.countryCode),
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(width: 10),
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
                Icons.public_rounded,
                size: 15,
                color: Color(0xFF9CA3AF),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Choisir un pays',
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

/// Convertit un code pays ISO (ex: "TG") en emoji drapeau, en décalant
/// chaque lettre vers les "Regional Indicator Symbols" Unicode.
String _flagEmoji(String countryCode) {
  if (countryCode.length != 2) return '🏳️';
  final base = 0x1F1E6; // 'A' régional indicator
  final chars = countryCode.toUpperCase().codeUnits;
  return String.fromCharCodes([
    base + (chars[0] - 65),
    base + (chars[1] - 65),
  ]);
}

/// Ouvre le bottom sheet de choix du pays. Renvoie le pays choisi via
/// `Navigator.pop(context, country)`, ou `null` si annulé.
/// [selected] peut être `null` si aucun pays n'a encore été choisi —
/// dans ce cas, aucune ligne n'apparaît présélectionnée dans la liste.
Future<CountryOperatorModel?> showCountryPicker({
  required BuildContext context,
  required List<CountryOperatorModel> countries,
  CountryOperatorModel? selected,
}) {
  return showModalBottomSheet<CountryOperatorModel>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => _CountryBottomSheet(
      countries: countries,
      selected: selected,
    ),
  );
}

class _CountryBottomSheet extends StatefulWidget {
  const _CountryBottomSheet({required this.countries, this.selected});

  final List<CountryOperatorModel> countries;
  final CountryOperatorModel? selected;

  @override
  State<_CountryBottomSheet> createState() => _CountryBottomSheetState();
}

class _CountryBottomSheetState extends State<_CountryBottomSheet> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<CountryOperatorModel> get _filtered {
    final q = _searchController.text.toLowerCase();
    if (q.isEmpty) return widget.countries;
    return widget.countries
        .where((c) => c.label.toLowerCase().contains(q))
        .toList();
  }

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
            'Choisir un pays',
            style: FontsStyles.bold.copyWith(fontSize: 17),
          ),
          const SizedBox(height: 16),

          if (widget.countries.length > 5) ...[
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.search_rounded,
                    size: 16,
                    color: Color(0xFFBBBBBB),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (_) => setState(() {}),
                      style: FontsStyles.regular.copyWith(fontSize: 13),
                      decoration: InputDecoration(
                        hintText: 'Rechercher un pays',
                        hintStyle: FontsStyles.regular.copyWith(
                          fontSize: 13,
                          color: const Color(0xFFBBBBBB),
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],

          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.5,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (final country in _filtered) ...[
                    _CountryRow(
                      country: country,
                      isSelected: widget.selected != null &&
                          country.key == widget.selected!.key,
                      onTap: () => Navigator.pop(context, country),
                    ),
                    if (country != _filtered.last) const SizedBox(height: 8),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CountryRow extends StatelessWidget {
  const _CountryRow({
    required this.country,
    required this.isSelected,
    required this.onTap,
  });

  final CountryOperatorModel country;
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
            Text(
              _flagEmoji(country.countryCode),
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    country.label,
                    style: FontsStyles.bold.copyWith(
                      fontSize: 13.5,
                      color: Palette.black,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    country.dialCode,
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
                  border:
                  Border.all(color: const Color(0xFFE0E0E0), width: 1.5),
                ),
              ),
          ],
        ),
      ),
    );
  }
}