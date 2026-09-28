import 'dart:io';
import 'package:corrispay/app/design/assets/assets_icons.dart';
import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:corrispay/app/design/palette.dart';
import 'package:corrispay/app/routes/routes_names.dart';
import 'package:corrispay/core/network/notification_service.dart';
import 'package:corrispay/features/bases/screens/splash_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../core/local/onboarding_provider.dart';
import '../../../core/local/userlocal_provider.dart';
import '../../../core/utils/functions.dart';
import '../../../l10n/app_localizations.dart';
import '../providers/app_provider.dart';
import '../providers/country_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  String version = '';

  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      if (mounted) setState(() => version = packageInfo.version);

      final appInfo = await ref.read(getAppInfoProvider(getPlatform()).future);

      if (!mounted) return;

      if (appInfo == null) {
        _goTo(RoutesNames.errorConnexionView);
        return;
      }

      final result = appInfo.latest_version.compareToVersion(
        packageInfo.version,
      );

      if (result > 0) {
        _goTo(RoutesNames.forceUpdateView, args: (appInfo, packageInfo));
        return;
      }

      await _initApp();
    } catch (e) {
      if (!mounted) return;
      _handleError(e);
    }
  }

  Future<void> _initApp() async {
    try {
      try {
        await NotificationService.initialize();
      } catch (e) {
        debugPrint('NotificationService init failed: $e');
      }
     // await ref.read(countryProvider.notifier).loadCountry();

      final hasSeenOnboarding = ref.read(onboardingProvider);
      final user = ref.read(userLocalProvider);

      if (!mounted) return;

      if (user != null) {
        if (user.hasCodePin == false) {
          _goTo(RoutesNames.main);
        } else {
          Navigator.pushReplacementNamed(
            context,
            RoutesNames.loginWithPinCode,
            arguments: user.id,
          );
        }
      } else {
        if (!hasSeenOnboarding) {
          Navigator.pushReplacementNamed(context, RoutesNames.onBoarding);
        } else {
          Navigator.pushReplacementNamed(context, RoutesNames.auth);
        }
      }
    } catch (e) {
      print("erru $e");
      if (!mounted) return;
      _handleError(e);
    }
  }

  void _goTo(String route, {Object? args}) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      route,
      (route) => false,
      arguments: args,
    );
  }

  void _handleError(Object e) {
    final isNetwork = e is SocketException;

    showDialog(
      context: context,
      builder: (_) {
        final loc = AppLocalizations.of(context)!;

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEDF5F5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.wifi_off_rounded,
                    color: Palette.petrolBlue,
                    size: 24,
                  ),
                ),
                const Gap(16),

                /// ✅ TITLE
                Text(
                  isNetwork ? loc.errorConnectionTitle : loc.errorGenericTitle,
                  style: FontsStyles.bold.copyWith(
                    fontSize: 18,
                    color: Palette.black,
                  ),
                ),

                const Gap(8),

                /// ✅ MESSAGE
                Text(
                  isNetwork
                      ? loc.errorConnectionMessage
                      : loc.errorGenericMessage,
                  style: FontsStyles.regular.copyWith(
                    fontSize: 13,
                    color: Colors.grey.shade500,
                    height: 1.5,
                  ),
                ),

                const Gap(20),

                /// ✅ BUTTON
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    _start();
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: Palette.petrolBlue,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Text(
                      loc.retry,
                      textAlign: TextAlign.center,
                      style: FontsStyles.bold.copyWith(
                        fontSize: 14,
                        color: Palette.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF0A2E33),
      body: SplashComponent(),
    );
  }
}
