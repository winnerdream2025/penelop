import 'package:corrispay/app/design/assets/assets_icons.dart';
import 'package:corrispay/app/design/palette.dart';
import 'package:corrispay/app/routes/routes_names.dart';
import 'package:corrispay/app/utils/app_urls.dart';
import 'package:corrispay/features/bases/widgets/default_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../app/design/fonts_styles.dart';
import '../../../../l10n/app_localizations.dart';
import '../../account/screens/language_choice_screen.dart';
import '../../bases/providers/language_provider.dart';

class AuthView extends ConsumerWidget {
  const AuthView({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;
    final localeProvider = ref.watch(localeProviderState);
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Palette.white,
      body: Stack(
        children: [

          Positioned.fill(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.04),
                BlendMode.srcIn,
              ),
              child: SvgPicture.asset(
                AssetsIcons.logo1,
                fit: BoxFit.cover,
              ),
            ),
          ),


          Padding(
            padding: EdgeInsets.fromLTRB(24, topPadding + 12, 24, bottomPadding + 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        isDismissible: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        builder: (context) => LanguageChoiceScreen(),
                      );
                    },
                    child: Container(
                      height: 34,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Palette.white,
                        borderRadius: BorderRadius.circular(99),
                        border: Border.all(
                          color: Palette.petrolBlue.withOpacity(0.4),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(localeProvider.flag, width: 20),
                          const Gap(6),
                          Text(
                            localeProvider.locale == const Locale('en')
                                ? t.english
                                : t.french,
                            style: FontsStyles.regular.copyWith(
                              fontSize: 12,
                              color: Palette.petrolBlue,
                            ),
                          ),
                          const Gap(4),
                          SvgPicture.asset(
                            AssetsIcons.arrowDownIos,
                            height: 10,
                            colorFilter: ColorFilter.mode(
                              Palette.petrolBlue,
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const Spacer(),


                Center(
                  child: Image.asset(
                    "assets/images/Icon_S1.png",
                    height: 100,
                  ),
                ),

                const Spacer(),


                DefaultButton(
                  padding: 14,
                  bgColor: Palette.petrolBlue,
                  text: t.login,
                  textColor: Palette.white,
                  onTap: () => Navigator.pushNamed(context, RoutesNames.login),
                ),

                const Gap(12),


                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade200)),
                    const Gap(12),
                    Text(
                      t.or,
                      style: FontsStyles.regular.copyWith(
                        fontSize: 12,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    const Gap(12),
                    Expanded(child: Divider(color: Colors.grey.shade200)),
                  ],
                ),

                const Gap(12),


                DefaultButton(
                  padding: 14,
                  bgColor: Palette.white,
                  text: t.register,
                  textColor: Palette.black,
                  brColor: Colors.grey.shade300,
                  onTap: () => Navigator.pushNamed(context, RoutesNames.phone),
                ),

                const Gap(20),


                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: t.termsTextStart,
                        style: FontsStyles.regular.copyWith(
                          fontSize: 11,
                          color: Colors.grey.shade500,
                          height: 1.6,
                        ),
                      ),
                      TextSpan(
                        text: t.termsOfUse,
                        style: FontsStyles.regular.copyWith(
                          fontSize: 11,
                          color: Palette.petrolBlue,
                          decoration: TextDecoration.underline,
                          decorationColor: Palette.petrolBlue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => _launchUrl(AppUrls.termsUrl),
                      ),
                      TextSpan(
                        text: t.and,
                        style: FontsStyles.regular.copyWith(
                          fontSize: 11,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      TextSpan(
                        text: t.privacyPolicyText,
                        style: FontsStyles.regular.copyWith(
                          fontSize: 11,
                          color: Palette.petrolBlue,
                          decoration: TextDecoration.underline,
                          decorationColor: Palette.petrolBlue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => _launchUrl(AppUrls.policyUrl),
                      ),
                      TextSpan(
                        text: '.',
                        style: FontsStyles.regular.copyWith(
                          fontSize: 11,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}