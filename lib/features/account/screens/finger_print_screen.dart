import 'package:corrispay/features/bases/providers/security_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../../../l10n/app_localizations.dart';

class FingerPrintScreen extends ConsumerWidget {
  const FingerPrintScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = AppLocalizations.of(context)!;
    final isFingerPrintEnabled = ref.watch(fingerprintEnabledProvider);

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


              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: Palette.petrolBlue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.fingerprint_rounded,
                  color: Palette.petrolBlue,
                  size: 28,
                ),
              ),

              const Gap(14),


              Text(
                tr.fingerPrint,
                style: FontsStyles.bold.copyWith(fontSize: 18),
              ),

              const Gap(6),

              Text(
                tr.fingerprintDescription,
                style: FontsStyles.regular.copyWith(
                  fontSize: 13,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),

              const Gap(20),


              ...[true, false].map((e) {
                final isSelected = isFingerPrintEnabled == e;

                return GestureDetector(
                  onTap: () async {
                    if (e == true) {
                      final authenticated = await ref
                          .read(securityServiceProvider)
                          .authenticate();
                      if (authenticated && !isFingerPrintEnabled) {
                        ref
                            .read(fingerprintEnabledProvider.notifier)
                            .setFingerPrint(true);
                        Navigator.pop(context);
                      }
                    } else {
                      ref
                          .read(fingerprintEnabledProvider.notifier)
                          .setFingerPrint(false);
                      Navigator.pop(context);
                    }
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

                        Icon(
                          e ? Icons.check_circle_outline : Icons.cancel_outlined,
                          size: 20,
                          color: isSelected
                              ? Palette.petrolBlue
                              : Colors.grey.shade400,
                        ),

                        const Gap(12),


                        Expanded(
                          child: Text(
                            e ? tr.enable : tr.disable,
                            style: FontsStyles.bold.copyWith(
                              fontSize: 15,
                              color: isSelected
                                  ? Palette.petrolBlue
                                  : Palette.black,
                            ),
                          ),
                        ),


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