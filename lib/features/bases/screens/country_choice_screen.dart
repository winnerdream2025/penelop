import 'package:corrispay/app/design/palette.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../app/design/assets/flag_assets.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../l10n/app_localizations.dart';
import '../../transactions/models/country_operator_model.dart';

class CountryChoiceScreen extends StatefulWidget {
  const CountryChoiceScreen({
    super.key,
    required this.selectedCountry,
    required this.updateSelectedCountry,
    required this.countries,
  });

  final CountryOperatorModel selectedCountry;
  final Function(CountryOperatorModel) updateSelectedCountry;
  final List<CountryOperatorModel> countries;

  @override
  State<CountryChoiceScreen> createState() => _CountryChoiceScreenState();
}

class _CountryChoiceScreenState extends State<CountryChoiceScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  late List<CountryOperatorModel> _filtered;

  static const double _itemHeight = 52.0;

  @override
  void initState() {
    super.initState();
    _filtered = widget.countries;

    _searchController.addListener(() {
      final q = _searchController.text.toLowerCase();
      setState(() {
        _filtered = q.isEmpty
            ? widget.countries
            : widget.countries
            .where((e) => e.label.toLowerCase().contains(q))
            .toList();
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final index = widget.countries.indexOf(widget.selectedCountry);
      if (index > 0 && _scrollController.hasClients) {
        final offset = (index * _itemHeight)
            .clamp(0.0, _scrollController.position.maxScrollExtent);
        _scrollController.animateTo(
          offset,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Bouton fermer
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.9),
              ),
              child: const Icon(Icons.close, size: 18, color: Colors.black87),
            ),
          ),
        ),

        const Gap(12),

        // Sheet
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    margin: const EdgeInsets.only(top: 12, bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                ),

                // Titre
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    loc.chooseCountry,
                    style: FontsStyles.bold.copyWith(fontSize: 18),
                  ),
                ),

                const Gap(12),

                // Recherche
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: FontsStyles.regular.copyWith(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: loc.search,
                        hintStyle: FontsStyles.regular.copyWith(
                          fontSize: 14,
                          color: Colors.grey.shade400,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          size: 18,
                          color: Colors.grey.shade400,
                        ),
                        border: InputBorder.none,
                        contentPadding:
                        const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ),

                const Gap(8),

                // Liste
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.fromLTRB(
                      16,
                      8,
                      16,
                      MediaQuery.of(context).padding.bottom + 16,
                    ),
                    itemCount: _filtered.length,
                    itemBuilder: (context, index) {
                      final e = _filtered[index];
                      final isSelected = widget.selectedCountry == e;

                      return GestureDetector(
                        onTap: () {
                          widget.updateSelectedCountry(e);
                          Navigator.pop(context);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          margin: const EdgeInsets.only(bottom: 4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Palette.petrolBlue.withOpacity(0.08)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? Palette.petrolBlue.withOpacity(0.25)
                                  : Colors.transparent,
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.asset(
                                  FlagAssets.url(e.countryCode),
                                  width: 28,
                                  height: 20,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const Gap(12),
                              Expanded(
                                child: Text(
                                  e.label,
                                  style: FontsStyles.regular.copyWith(
                                    fontSize: 14,
                                    color: isSelected
                                        ? Palette.petrolBlue
                                        : Palette.black,
                                  ),
                                ),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 150),
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected
                                      ? Palette.petrolBlue
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: isSelected
                                        ? Palette.petrolBlue
                                        : Colors.grey.shade300,
                                    width: 1.5,
                                  ),
                                ),
                                child: isSelected
                                    ? const Icon(Icons.check,
                                    color: Colors.white, size: 12)
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}