import 'package:corrispay/app/routes/routes_names.dart';
import 'package:corrispay/features/bases/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../../../core/local/merchant_account.provider.dart';

class MerchantSpaceSheet extends ConsumerWidget {
  const MerchantSpaceSheet({super.key, required this.goGoMerchantSpace});
  final VoidCallback goGoMerchantSpace;

  static void show(BuildContext context, VoidCallback goGoMerchantSpace) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => MerchantSpaceSheet(goGoMerchantSpace: goGoMerchantSpace),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final merchantAccount = ref.read(merchantAccountLocalProvider);
    final hasMerchantAccount = merchantAccount != null;

    return Container(
      decoration: const BoxDecoration(
        color: Palette.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // ── Icône — badge "+" seulement si PAS de compte ──
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  color: Palette.petrolBlue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.storefront_outlined,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              if (!hasMerchantAccount)
                Positioned(
                  bottom: -2,
                  right: -2,
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEF9F27),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 16),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 20),

          // ── Titre — nom du commerce si compte existant, sinon
          // "Merchant Space" générique ──
          Text(
            hasMerchantAccount ? merchantAccount.designation : 'Merchant Space',
            style: FontsStyles.bold.copyWith(
              fontSize: 19,
              color: Palette.black,
            ),
          ),

          // ── Code marchand, affiché SEULEMENT si le compte existe ──
          if (hasMerchantAccount) ...[
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFF1EFE8),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                merchantAccount.merchantCode,
                style: FontsStyles.medium.copyWith(
                  fontSize: 11,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ],

          const SizedBox(height: 10),

          Text(
            hasMerchantAccount
                ? "Gérez votre espace marchand et vos transferts."
                : "Créez votre compte marchand pour recevoir des paiements directement sur CaurisPay.",
            textAlign: TextAlign.center,
            style: FontsStyles.regular.copyWith(
              fontSize: 13,
              color: Colors.grey.shade600,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 22),

          // ── Pilules — SEULEMENT si pas encore de compte, pour
          // vendre la fonctionnalité avant inscription ──
          if (!hasMerchantAccount)
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: const [
                _FeaturePill(
                  icon: Icons.receipt_long_outlined,
                  label: 'Paiements',
                ),
                _FeaturePill(icon: Icons.code_rounded, label: 'API marchand'),
                _FeaturePill(icon: Icons.qr_code_rounded, label: 'QR marchand'),
              ],
            ),

          if (!hasMerchantAccount) const SizedBox(height: 28),

          // ── Boutons — UN seul si pas de compte, DEUX si compte existant ──
          if (hasMerchantAccount)
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 52,
                    child: DefaultButton(
                      textColor: Palette.petrolBlue,
                      bgColor: Palette.white,
                      brColor: Palette.petrolBlue,
                      raduis: 16,
                      text: "Transférer",
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          RoutesNames.internTransferView,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 52,
                    child: DefaultButton(
                      text: "Acceder",
                      raduis: 16,
                      onTap: () {
                        Navigator.pop(context);
                        goGoMerchantSpace();
                      },
                    ),
                  ),
                ),
              ],
            )
          else
            SizedBox(
              width: double.infinity,
              height: 52,
              child: DefaultButton(
                text: 'Créer mon compte marchand',
                onTap: () {
                  Navigator.pushReplacementNamed(
                    context,
                    RoutesNames.merchantRegistration,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _FeaturePill extends StatelessWidget {
  const _FeaturePill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF1EFE8),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.grey.shade700),
          const SizedBox(width: 6),
          Text(
            label,
            style: FontsStyles.medium.copyWith(
              fontSize: 12,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
