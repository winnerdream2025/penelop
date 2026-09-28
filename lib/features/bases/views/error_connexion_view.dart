import 'package:corrispay/app/design/palette.dart';
import 'package:corrispay/app/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../app/design/assets/assets_icons.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../core/utils/functions.dart';
import '../../../l10n/app_localizations.dart';
import '../providers/app_provider.dart';
import '../widgets/default_button.dart';

class ErrorConnexionView extends ConsumerStatefulWidget {
  const ErrorConnexionView({super.key});

  @override
  ConsumerState<ErrorConnexionView> createState() => _ErrorConnexionViewState();
}

class _ErrorConnexionViewState extends ConsumerState<ErrorConnexionView> {
  bool isLoading = false;

  Future<void> _retry() async {
    if (isLoading) return;

    setState(() => isLoading = true);

    try {
      /// 🔥 RESET CACHE
      ref.invalidate(getAppInfoProvider(getPlatform()));

      await Future.delayed(const Duration(milliseconds: 500));

      if (!mounted) return;

      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesNames.splash,
        (route) => false,
      );
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Palette.white,
      appBar: AppBar(backgroundColor: Palette.white),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            AnimatedScale(
              scale: 1,
              duration: const Duration(milliseconds: 400),
              child: Text(
                loc.connectionErrorTitle,
                style: FontsStyles.black.copyWith(
                  color: Palette.petrolBlue,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const Gap(16),

            Text(
              loc.connectionErrorDescription,
              textAlign: TextAlign.center,
              style: FontsStyles.regular.copyWith(color: Palette.black),
            ),

            const Gap(24),

            Expanded(
              child: SvgPicture.asset(
                AssetsIcons.connexionOff,
                width: MediaQuery.of(context).size.width * 0.5,
                colorFilter: ColorFilter.mode(
                  Colors.grey.shade200,
                  BlendMode.srcIn,
                ),
              ),
            ),

            const Gap(24),

            DefaultButton(
              bgColor: Palette.petrolBlue,
              hPadding: 16,
              text: loc.retry,
              onTap: _retry,
            ),

            const Gap(16),
            const Gap(24),
          ],
        ),
      ),
    );
  }
}
