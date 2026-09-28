import 'package:flutter_riverpod/legacy.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

import '../../account/screens/language_choice_screen.dart';

class LocaleNotifier extends StateNotifier<Language> {
  final GetStorage _box;
  static const String prefKey = 'selected_language';

  LocaleNotifier(this._box) : super(languages.first) {
    _loadLocale();
  }

  void _loadLocale() {
    final savedLangCode = _box.read(prefKey);

    if (savedLangCode != null) {
      state = languages.firstWhere(
            (lang) => lang.locale.languageCode == savedLangCode,
        orElse: () => languages.first,
      );
    } else {
      final systemLocale =
          WidgetsBinding.instance.platformDispatcher.locale.languageCode;

      state = languages.firstWhere(
            (lang) => lang.locale.languageCode == systemLocale,
        orElse: () => languages.first,
      );

      // ── Sauvegarder pour que getLanguageCode() le trouve aussi
      _box.write(prefKey, state.locale.languageCode);
    }
  }

  void setLanguage(Language language) {
    state = language;
    print(language.locale.languageCode);

    _box.write(prefKey, language.locale.languageCode);
    print(_box.read(prefKey) + "he");
  }
}

// Provider pour le LocaleNotifier
final localeProviderState = StateNotifierProvider<LocaleNotifier, Language>((ref) {
  final box = GetStorage();
  return LocaleNotifier(box);
});



class LanguageUtils {
  static const String prefKey = 'selected_language';

  static String getLanguageCode() {
    final box = GetStorage();
    final savedLangCode = box.read(prefKey);

    if (savedLangCode != null) return savedLangCode;

    // ── Fallback : langue du téléphone
    final systemLocale =
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;

    // Ne retourner que fr ou en — les deux langues supportées
    return (systemLocale == 'fr') ? 'fr' : 'en';
  }
}