import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:corrispay/l10n/app_localizations.dart';
import 'package:corrispay/features/bases/providers/language_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/router.dart';
import 'app/routes/routes_names.dart';
import 'features/account/screens/language_choice_screen.dart';
import 'features/beneficiary/repositories/devices_contacts_repository.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();
List<Language> languages = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {}

  runApp(ProviderScope(child: const MyApp()));

  final _ = Provider<DeviceContactsRepository>((ref) {
    final repo = DeviceContactsRepository(GetStorage());
    repo.startListeningForChanges();
    ref.onDispose(() => repo.stopListeningForChanges());

    return repo;
  });
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProviderState);
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesNames.splash,
      onGenerateRoute: Routes.generateRoute,
      locale: locale.locale,
      supportedLocales: const [Locale('fr'), Locale('en')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
