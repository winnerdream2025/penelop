import 'dart:io';

import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:corrispay/core/network/notification_service.dart';
import 'package:corrispay/core/utils/functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/design/palette.dart';
import '../../../app/routes/routes_names.dart';
import '../../../core/local/onboarding_provider.dart';
import '../../../core/local/userlocal_provider.dart';
import '../../../l10n/app_localizations.dart';
import '../models/app_info.dart';
import '../providers/country_provider.dart';

class ForceUpdateView extends ConsumerStatefulWidget {
  const ForceUpdateView({super.key, required this.infos});

  final (AppInfo, PackageInfo) infos;

  @override
  ConsumerState<ForceUpdateView> createState() => _ForceUpdateViewState();
}

class _ForceUpdateViewState extends ConsumerState<ForceUpdateView> {
  late final AppInfo config;
  late final String currentVersion;

  @override
  void initState() {
    super.initState();
    config = widget.infos.$1;
    currentVersion = widget.infos.$2.version;
  }

  bool get isBlocking =>
      currentVersion.compareToVersion(config.min_version) < 0;

  bool get canIgnore => !isBlocking && !config.force_update;

  static const String _iosAppStoreId = '6812558506';

  Future<void> onUpdate() async {
    final Uri url;
    if (!kIsWeb && Platform.isIOS) {
      url = Uri.parse('https://apps.apple.com/app/id$_iosAppStoreId');
    } else {
      url = Uri.parse(
        'https://play.google.com/store/apps/details?id=com.pay.corrispay',
      );
    }
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> onIgnore() async {
    try {
      NotificationService.initialize();
      await ref.read(countryProvider.notifier).loadCountry();

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
    } catch (_) {
      if (!mounted) return;
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

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Palette.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const Gap(24),

                // VERSION BADGE
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    loc.versionLabel(config.latest_version),
                    style: FontsStyles.bold.copyWith(
                      fontSize: 11,
                      color: Colors.grey.shade500,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),

                const Gap(32),

                // ICON
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFF0F0F0),
                      width: 1.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFE8E8E8),
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: const BoxDecoration(
                            color: Palette.petrolBlue,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.system_update_rounded,
                            size: 30,
                            color: Palette.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const Gap(32),

                // TITRE
                Text(
                  isBlocking
                      ? loc.updateRequiredTitle
                      : loc.newVersionAvailableTitle,
                  textAlign: TextAlign.center,
                  style: FontsStyles.bold.copyWith(
                    fontSize: 24,
                    color: Palette.black,
                    height: 1.25,
                  ),
                ),

                const Gap(10),

                // DESCRIPTION
                Text(
                  isBlocking
                      ? loc.updateRequiredDescription
                      : loc.updateAvailableDescription,
                  textAlign: TextAlign.center,
                  style: FontsStyles.regular.copyWith(
                    fontSize: 13,
                    color: Colors.grey.shade400,
                    height: 1.7,
                  ),
                ),

                const Gap(28),
                const Divider(color: Color(0xFFF5F5F5), height: 1),
                const Gap(24),

                // VERSION INFOS
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UpdateVersionItem(
                      label: loc.currentVersion,
                      value: currentVersion,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        width: 1,
                        height: 28,
                        child: ColoredBox(color: Color(0xFFF0F0F0)),
                      ),
                    ),
                    UpdateVersionItem(
                      label: loc.newVersion,
                      value: config.latest_version,
                    ),
                  ],
                ),

                const Spacer(),

                // UPDATE BUTTON
                GestureDetector(
                  onTap: onUpdate,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Palette.petrolBlue,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      loc.update,
                      textAlign: TextAlign.center,
                      style: FontsStyles.bold.copyWith(
                        fontSize: 15,
                        color: Palette.white,
                      ),
                    ),
                  ),
                ),

                if (canIgnore) ...[
                  const Gap(10),
                  GestureDetector(
                    onTap: onIgnore,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: Palette.goldYellow.withOpacity(0.07),
                        border: Border.all(
                          color: Palette.goldYellow.withOpacity(0.18),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        loc.ignoreForNow,
                        textAlign: TextAlign.center,
                        style: FontsStyles.bold.copyWith(
                          fontSize: 14,
                          color: Palette.goldYellow,
                        ),
                      ),
                    ),
                  ),
                ],

                const Gap(32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ITEM VERSION
class UpdateVersionItem extends StatelessWidget {
  const UpdateVersionItem({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: FontsStyles.regular.copyWith(
            fontSize: 10,
            color: Colors.grey.shade400,
          ),
        ),
        const Gap(3),
        Text(
          value,
          style: FontsStyles.bold.copyWith(fontSize: 13, color: Palette.black),
        ),
      ],
    );
  }
}
