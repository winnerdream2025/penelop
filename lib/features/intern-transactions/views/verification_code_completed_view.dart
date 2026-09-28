import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:corrispay/app/design/palette.dart';
import 'package:corrispay/app/routes/routes_names.dart';
import 'package:corrispay/features/bases/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../bases/models/dashboard_data.dart';
import '../../../l10n/app_localizations.dart';

class VerificationCodeCompletedView extends StatelessWidget {
  const VerificationCodeCompletedView({
    super.key,
    required this.dashboardData,
  });

  final DashboardData dashboardData;


  void _goToMain(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesNames.main,
          (route) => false,
      arguments: dashboardData,
    );
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _goToMain(context);
      },
      child: Scaffold(
        backgroundColor: Palette.teal,
        body: SafeArea(
          child: Stack(
            children: [

              const Positioned(
                top: -60,
                right: -60,
                child: _DecorativeCircle(size: 180, opacity: 0.06),
              ),
              const Positioned(
                bottom: 160,
                left: -40,
                child: _DecorativeCircle(size: 140, opacity: 0.05),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),

                    // ── Icône en couches ─────────────────────────
                    const _LayeredSuccessIcon(),

                    const Gap(24),

                    // ── Titre ────────────────────────────────────
                    Text(
                      tr.verificationSuccessTitle,
                      textAlign: TextAlign.center,
                      style: FontsStyles.bold.copyWith(
                        color: Palette.white,
                        fontSize: 23,
                      ),
                    ),

                    const Gap(10),

                    // ── Message ──────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        tr.success_operation,
                        textAlign: TextAlign.center,
                        style: FontsStyles.regular.copyWith(
                          color: Colors.white.withOpacity(0.75),
                          fontSize: 13.5,
                          height: 1.6,
                        ),
                      ),
                    ),


                      const Gap(28),
                     // _ReferenceCard(reference: "reference!"),


                    const Spacer(flex: 2),

                    // ── Bouton continuer ─────────────────────────
                    DefaultButton(
                      text: tr.continueButton,
                      bgColor: Colors.white,
                      padding: 16,
                      textStyle: FontsStyles.bold.copyWith(
                        fontSize: 15,
                        color: Palette.teal,
                      ),
                      onTap: () => _goToMain(context),
                    ),

                    const Gap(14),

                    Text(
                      tr.auto_redirect_home,
                      style: FontsStyles.regular.copyWith(
                        fontSize: 11.5,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),

                    const Gap(16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DecorativeCircle extends StatelessWidget {
  const _DecorativeCircle({required this.size, required this.opacity});

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(opacity),
      ),
    );
  }
}

class _LayeredSuccessIcon extends StatelessWidget {
  const _LayeredSuccessIcon();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 130,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.08),
            ),
          ),
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.14),
            ),
          ),
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: const Icon(
              Icons.check_rounded,
              color: Palette.teal,
              size: 32,
            ),
          ),
          Positioned(
            top: 6,
            right: 2,
            child: Container(
              width: 14,
              height: 14,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Palette.orange,
              ),
            ),
          ),
          Positioned(
            bottom: 14,
            left: 0,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Palette.goldYellow,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReferenceCard extends StatelessWidget {
  const _ReferenceCard({required this.reference});

  final String reference;

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: const Icon(
                  Icons.receipt_long_outlined,
                  size: 16,
                  color: Colors.white,
                ),
              ),
              const Gap(10),
              Text(
               tr.reference,
                style: FontsStyles.regular.copyWith(
                  fontSize: 12.5,
                  color: Colors.white.withOpacity(0.85),
                ),
              ),
            ],
          ),
          Text(
            reference,
            style: FontsStyles.bold.copyWith(
              fontSize: 12.5,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}