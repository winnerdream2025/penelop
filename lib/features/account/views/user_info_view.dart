import 'package:corrispay/app/routes/routes_names.dart';
import 'package:corrispay/features/account/widgets/custom_divider.dart';
import 'package:corrispay/features/bases/widgets/rounded_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../../../core/local/userlocal_provider.dart';
import '../../../l10n/app_localizations.dart';
import '../widgets/info_row.dart';

class UserInfoView extends ConsumerWidget {
  const UserInfoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = AppLocalizations.of(context)!;
    final user = ref.watch(userLocalProvider);

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Palette.petrolBlue),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             RoundedBackButton(),

              const Gap(16),


              Text(
                tr.personalInformation,
                style: FontsStyles.bold.copyWith(fontSize: 24),
              ),

              const Gap(6),

              Text(
                tr.personalInfoDescription,
                style: FontsStyles.regular.copyWith(
                  fontSize: 13,
                  color: Colors.black45,
                ),
              ),

              const Gap(20),


              Center(
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Palette.petrolBlue.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      "${user.firstName[0]}${user.lastName[0]}".toUpperCase(),
                      style: FontsStyles.bold.copyWith(
                        fontSize: 22,
                        color: Palette.petrolBlue,
                      ),
                    ),
                  ),
                ),
              ),

              const Gap(24),


              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    InfoRow(label: tr.lastName, value: user.lastName.toUpperCase()),
                    CustomDivider(),
                    InfoRow(label: tr.firstName, value: user.firstName),
                    CustomDivider(),
                    InfoRow(
                      label: tr.email,
                      value: user.email ?? tr.not_informed,
                      valueColor: user.email == null
                          ? Colors.grey.shade400
                          : Palette.black,
                      actionText: user.email == null ? tr.add : null,
                      onAction: user.email == null
                          ? () => Navigator.pushNamed(context, RoutesNames.addEmail)
                          : null,
                    ),
                    CustomDivider(),
                    InfoRow(label: tr.phoneNumber, value: user.phoneNumber),
                    CustomDivider(),
                    InfoRow(label: tr.country, value: user.country, isLast: true),
                  ],
                ),
              ),

              const Gap(32),
            ],
          ),
        ),
      ),
    );
  }
}


