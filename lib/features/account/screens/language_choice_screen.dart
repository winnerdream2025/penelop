import 'package:corrispay/app/design/assets/flag_assets.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../../../l10n/app_localizations.dart';
import '../../bases/providers/language_provider.dart';

class Language {
  final String name;
  final Locale locale;
  final String flag;

  Language({required this.name, required this.locale, required this.flag});
}

final languages = [
  Language(name: "Français", locale: const Locale("fr"), flag: FlagAssets.fr),
  Language(name: "English", locale: const Locale("en"), flag: FlagAssets.gb),
];

class LanguageChoiceScreen extends ConsumerWidget {
  const LanguageChoiceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeProvider = ref.watch(localeProviderState);
    final tr = AppLocalizations.of(context)!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [

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
              child: const Icon(
                Icons.close,
                size: 18,
                color: Colors.black87,
              ),
            ),
          ),
        ),

        const Gap(12),


        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(
            24,
            24,
            24,
            MediaQuery.of(context).padding.bottom + 24,
          ),
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
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ),

              // Titre
              Text(
                tr.language,
                style: FontsStyles.bold.copyWith(fontSize: 18),
              ),

              const Gap(6),

              Text(
                tr.chooseLanguageDescription,
                style: FontsStyles.regular.copyWith(
                  fontSize: 13,
                  color: Colors.black54,
                ),
              ),

              const Gap(20),


              ...languages.map((language) {
                final isSelected = localeProvider.locale == language.locale;

                return GestureDetector(
                  onTap: () {
                    ref
                        .read(localeProviderState.notifier)
                        .setLanguage(language);
                    Navigator.pop(context);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Palette.petrolBlue.withOpacity(0.08)
                          : Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isSelected
                            ? Palette.petrolBlue.withOpacity(0.3)
                            : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Drapeau
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.asset(
                            language.flag,
                            width: 28,
                            height: 20,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const Gap(12),

                        // Nom langue
                        Expanded(
                          child: Text(
                            language.locale == const Locale('en')
                                ? tr.english
                                : tr.french,
                            style: FontsStyles.bold.copyWith(
                              fontSize: 15,
                              color: isSelected
                                  ? Palette.petrolBlue
                                  : Palette.black,
                            ),
                          ),
                        ),

                        // Indicateur sélection
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 22,
                          height: 22,
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
                              ? const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 13,
                          )
                              : null,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}