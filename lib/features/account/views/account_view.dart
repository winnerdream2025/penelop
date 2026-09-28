import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:corrispay/app/design/palette.dart';
import 'package:corrispay/app/routes/routes_names.dart';
import 'package:corrispay/app/utils/app_urls.dart';
import 'package:corrispay/core/local/userlocal_provider.dart';
import 'package:corrispay/core/utils/functions.dart';
import 'package:corrispay/features/account/screens/finger_print_screen.dart';
import 'package:corrispay/features/account/screens/language_choice_screen.dart';
import 'package:corrispay/features/account/widgets/custom_divider.dart';
import 'package:corrispay/features/account/widgets/setting_tile.dart';
import 'package:corrispay/features/account/widgets/settings_card.dart';
import 'package:corrispay/features/account/widgets/tile.dart';
import 'package:corrispay/features/auth/providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../l10n/app_localizations.dart';
import '../../bases/providers/language_provider.dart';
import '../../bases/providers/security_provider.dart';

class AccountView extends ConsumerWidget {
  const AccountView({super.key});

  Future<void> _showDeleteAccountDialog(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations tr,
  ) async {
    final confirmed = await showCupertinoDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(tr.delete_account_confirm_title),
        content: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(tr.delete_account_confirm_message),
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(tr.cancel),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(tr.delete_account_confirm_button),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    showLoading();
    final response = await ref.refresh(requestDeletionProvider.future);
    hideLoading();

    if (!context.mounted) return;
    if (response == null || !response.status) {
      showErrorMessage(response?.message);
      return;
    }
    showSuccessMessage(tr.deletion_request_success);
  }

  Future<void> _showCancelDeletionDialog(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations tr,
  ) async {
    final confirmed = await showCupertinoDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(tr.cancel_deletion_confirm_title),
        content: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(tr.cancel_deletion_confirm_message),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(tr.delete_account_confirm_button),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(tr.cancel_deletion_confirm_button),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    showLoading();
    final response = await ref.refresh(cancelDeletionProvider.future);
    hideLoading();

    if (!context.mounted) return;
    if (response == null || !response.status) {
      showErrorMessage(response?.message);
      return;
    }
    showSuccessMessage(tr.deletion_cancel_success);
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = AppLocalizations.of(context)!;
    final localeProvider = ref.watch(localeProviderState);
    final isFingerEnabled = ref.watch(fingerprintEnabledProvider);
    final user = ref.watch(userLocalProvider);

    if (user == null) return const Scaffold(backgroundColor: Palette.white);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(24),
              Text(tr.settings, style: FontsStyles.bold.copyWith(fontSize: 22)),
              const Gap(14),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RoutesNames.userAccountInfo);
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Palette.petrolBlue.withOpacity(0.1),
                          shape: BoxShape.circle,
                          /**
                           *  shape: BoxShape.circle,
                              image: DecorationImage(
                              image: NetworkImage(
                              "https://cdn.prod.website-files.com/5e51c674258ffe10d286d30a/5e535727550b765a60f50817_peep-47.png",
                              ),
                              ),
                           */
                        ),
                        child: Center(
                          child: Text(
                            '${user.firstName[0]}${user.lastName[0]}'
                                .toUpperCase(),
                            style: FontsStyles.bold.copyWith(
                              fontSize: 16,
                              color: Palette.petrolBlue,
                            ),
                          ),
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${user.firstName} ${user.lastName}',
                              style: FontsStyles.bold.copyWith(
                                fontSize: 15,
                                color: Palette.black,
                              ),
                            ),
                            const Gap(2),
                            Text(
                              user.phoneNumber,
                              style: FontsStyles.regular.copyWith(
                                fontSize: 12,
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 18,
                        color: Colors.grey.shade300,
                      ),
                    ],
                  ),
                ),
              ),

              const Gap(12),
              SectionTitle(title: tr.security),
              const Gap(6),
              SettingsCard(
                children: [
                  Tile(
                    title: tr.fingerPrint,
                    icon: Icons.fingerprint_rounded,
                    trailing: Text(
                      isFingerEnabled ? tr.enable : tr.disable,
                      style: FontsStyles.bold.copyWith(
                        fontSize: 12,
                        color: isFingerEnabled
                            ? Colors.green
                            : Colors.grey.shade400,
                      ),
                    ),
                    onTap: () => showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      isDismissible: true,
                      builder: (context) => FingerPrintScreen(),
                    ),
                  ),
                  CustomDivider(),
                  Tile(
                    title: tr.changePassword,
                    icon: Icons.lock_outline_rounded,
                    onTap: () => Navigator.pushNamed(
                      context,
                      RoutesNames.updatePassword,
                    ),
                  ),
                  CustomDivider(),
                  Tile(
                    title: user.hasCodePin == true
                        ? tr.changePinCode
                        : tr.createPinCode,
                    icon: Icons.pin_outlined,
                    warning: user.hasCodePin == false,
                    onTap: () {
                      if (user.hasCodePin == false) {
                        Navigator.pushNamed(
                          context,
                          RoutesNames.createRequiredCodeView,
                        );
                      } else {
                        Navigator.pushNamed(context, RoutesNames.setPasscode);
                      }
                    },
                  ),
                ],
              ),

              const Gap(12),
              SectionTitle(title: tr.preferences),
              const Gap(6),
              SettingsCard(
                children: [
                  Tile(
                    title: tr.privacyPolicy,
                    icon: Icons.shield_outlined,
                    onTap: () => _launchUrl(AppUrls.policyUrl),
                  ),
                  CustomDivider(),
                  Tile(
                    title: tr.language,
                    icon: Icons.language_rounded,
                    trailing: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: Image.asset(
                            localeProvider.flag,
                            width: 20,
                            height: 14,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Gap(6),
                        Text(
                          localeProvider.locale == const Locale('en')
                              ? tr.english
                              : tr.french,
                          style: FontsStyles.regular.copyWith(
                            fontSize: 12,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                    onTap: () => showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      isDismissible: true,
                      builder: (context) => LanguageChoiceScreen(),
                    ),
                  ),
                ],
              ),

              const Gap(12),

              SectionTitle(title: tr.support),
              const Gap(6),
              SettingsCard(
                children: [
                  Tile(
                    title: tr.support,
                    icon: Icons.headset_mic_outlined,
                    onTap: () => Navigator.pushNamed(
                      context,
                      RoutesNames.contactSupportView,
                    ),
                  ),
                ],
              ),

              if (user.deletionRequestedAt != null) ...[  
                const Gap(12),
                _buildDeletionPendingBanner(context, ref, user, tr),
              ],

              const Gap(20),

              GestureDetector(
                onTap: () async {
                  showLoading();
                  await ref.read(logoutProvider.future);
                  await ref.read(userLocalProvider.notifier).clearUser();
                  ref.invalidate(userLocalProvider);
                  hideLoading();
                  if (context.mounted) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RoutesNames.auth,
                      (route) => false,
                    );
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.red.withOpacity(0.2),
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    tr.logout,
                    textAlign: TextAlign.center,
                    style: FontsStyles.bold.copyWith(
                      fontSize: 14,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),

              if (user.deletionRequestedAt == null) ...[  
                const Gap(10),
                GestureDetector(
                  onTap: () => _showDeleteAccountDialog(context, ref, tr),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.red.withValues(alpha: 0.2),
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      tr.delete_account,
                      textAlign: TextAlign.center,
                      style: FontsStyles.regular.copyWith(
                        fontSize: 14,
                        color: Colors.red.shade400,
                      ),
                    ),
                  ),
                ),
              ],

              const Gap(28),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeletionPendingBanner(
    BuildContext context,
    WidgetRef ref,
    user,
    AppLocalizations tr,
  ) {
    final scheduledDate =
        DateTime.tryParse(user.deletionScheduledFor as String? ?? '');
    final formattedDate = scheduledDate != null
        ? '${scheduledDate.day.toString().padLeft(2, '0')}/${scheduledDate.month.toString().padLeft(2, '0')}/${scheduledDate.year}'
        : (user.deletionScheduledFor as String? ?? '');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.orange.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: Colors.orange,
            size: 20,
          ),
          const Gap(10),
          Expanded(
            child: Text(
              tr.deletion_pending_banner(formattedDate),
              style: FontsStyles.regular.copyWith(
                fontSize: 13,
                color: Colors.orange.shade700,
              ),
            ),
          ),
          const Gap(8),
          GestureDetector(
            onTap: () => _showCancelDeletionDialog(context, ref, tr),
            child: Text(
              tr.cancel_deletion,
              style: FontsStyles.bold.copyWith(
                fontSize: 13,
                color: Colors.orange.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
