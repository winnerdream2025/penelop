import 'package:corrispay/app/design/assets/assets_ressources.dart';
import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:corrispay/app/design/palette.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../l10n/app_localizations.dart';

class ChargingMethodScreen extends StatelessWidget {
  const ChargingMethodScreen({super.key, required this.price});
  final double price;

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return IntrinsicHeight(
      child: Column(
        children: [
          // ── Handle ────────────────────────────────────────────
          const Gap(12),
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const Gap(16),

          // ── Contenu principal ─────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 36),
            decoration: const BoxDecoration(
              color: Palette.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr.rechargeMethod,
                  style: FontsStyles.bold.copyWith(
                    fontSize: 20,
                    color: Palette.black,
                  ),
                ),
                const Gap(3),
                Text(
                  tr.selectRechargeMethod,
                  style: FontsStyles.regular.copyWith(
                    fontSize: 12,
                    color: Colors.grey.shade400,
                  ),
                ),
                const Gap(20),
                ...PaymentMethodType.values.map(
                      (method) => PaymentMethodTile(
                    method: method,
                    onTap: () => Navigator.pop(context, method),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Tuile méthode de paiement ─────────────────────────────────────────────────

class PaymentMethodTile extends StatelessWidget {
  const PaymentMethodTile({
    super.key,
    required this.method,
    required this.onTap,
  });

  final PaymentMethodType method;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Palette.white,
          border: Border.all(color: const Color(0xFFF0F0F0), width: 1.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // Icône
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: method.bgColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(child: method.iconWidget),
            ),
            const Gap(14),
            // Titre + description
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method.title,
                    style: FontsStyles.bold.copyWith(
                      fontSize: 14,
                      color: Palette.black,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    method.description,
                    style: FontsStyles.regular.copyWith(
                      fontSize: 11,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Enum méthodes de paiement ─────────────────────────────────────────────────

enum PaymentMethodType {
  wave(
    title: 'Wave',
    description: 'Payer via votre compte Wave',
    image: AssetsRessources.paypal,
  ),
  card(
    title: 'Carte bancaire',
    description: 'Visa, Mastercard, etc.',
    image: AssetsRessources.paypal,
  ),
  mobileMoney(
    title: 'Mobile Money',
    description: 'Orange Money, Free Money...',
    image: AssetsRessources.mobileMoney,
  );

  final String title;
  final String description;
  final String image;

  const PaymentMethodType({
    required this.title,
    required this.description,
    required this.image,
  });

  Color get bgColor {
    switch (this) {
      case PaymentMethodType.wave:
        return const Color(0xFF1CC8C4).withOpacity(0.10);
      case PaymentMethodType.card:
        return const Color(0xFF1A56DB).withOpacity(0.08);
      case PaymentMethodType.mobileMoney:
        return Palette.orange.withOpacity(0.08);
    }
  }

  Widget get iconWidget {
    switch (this) {
      case PaymentMethodType.wave:
        return SizedBox(
          width: 26,
          height: 26,
          child: CustomPaint(painter: WaveIconPainter()),
        );
      case PaymentMethodType.card:
        return const Icon(
          Icons.credit_card_rounded,
          color: Color(0xFF1A56DB),
          size: 24,
        );
      case PaymentMethodType.mobileMoney:
        return const Icon(
          Icons.phone_android_rounded,
          color: Palette.orange,
          size: 24,
        );
    }
  }
}

// ── Peintre Wave ──────────────────────────────────────────────────────────────

class WaveIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1CC8C4)
      ..style = PaintingStyle.fill;

    final path = Path();
    final w = size.width;
    final h = size.height;

    path.moveTo(w * 0.05, h * 0.2);
    path.lineTo(w * 0.22, h * 0.8);
    path.lineTo(w * 0.38, h * 0.42);
    path.lineTo(w * 0.5, h * 0.62);
    path.lineTo(w * 0.62, h * 0.42);
    path.lineTo(w * 0.78, h * 0.8);
    path.lineTo(w * 0.95, h * 0.2);
    path.lineTo(w * 0.82, h * 0.2);
    path.lineTo(w * 0.78, h * 0.55);
    path.lineTo(w * 0.62, h * 0.3);
    path.lineTo(w * 0.5, h * 0.5);
    path.lineTo(w * 0.38, h * 0.3);
    path.lineTo(w * 0.22, h * 0.55);
    path.lineTo(w * 0.18, h * 0.2);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}