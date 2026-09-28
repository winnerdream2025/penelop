import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:corrispay/app/design/palette.dart';
import 'package:corrispay/features/bases/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/routes/routes_names.dart';
import '../../core/local/onboarding_provider.dart';
import '../../l10n/app_localizations.dart';

class OnboardingOneView extends ConsumerStatefulWidget {
  const OnboardingOneView({super.key});

  @override
  ConsumerState<OnboardingOneView> createState() => _OnboardingOneViewState();
}

class _OnboardingOneViewState extends ConsumerState<OnboardingOneView> {
  int _index = 0;
  late final PageController _pageController;

  final List<Color> _accentColors = [
    Palette.petrolBlue,
    Palette.orange,
  ];

  final List<Color> _bgColors = [
    const Color(0xFFE0F0F1),
    const Color(0xFFFFF0E6),
  ];

  final List<Widget> _icons = const [
    _PaymentIcon(),
    _RateIcon(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_index < _icons.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeInOut,
      );
    } else {
      ref.read(onboardingProvider.notifier).markAsSeen();
      Navigator.pushReplacementNamed(context, RoutesNames.auth);
    }
  }

  @override
  Widget build(BuildContext context) {
    final titles = [
      AppLocalizations.of(context)!.onboardingTitleOne,
      AppLocalizations.of(context)!.onboardingTitleTwo,
    ];

    final descriptions = [
      AppLocalizations.of(context)!.onboardingDescriptionOne,
      AppLocalizations.of(context)!.onboardingDescriptionTwo,
    ];

    final topPad = MediaQuery.of(context).padding.top;
    final bottomPad = MediaQuery.of(context).padding.bottom;
    final accent = _accentColors[_index];

    return Scaffold(
      backgroundColor: Palette.white,
      body: Column(
        children: [
          Gap(topPad + 16),


          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _icons.length,
              onPageChanged: (value) => setState(() => _index = value),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      /// Illustration area
                      Expanded(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            color: _bgColors[index],
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Center(child: _icons[index]),
                        ),
                      ),

                      const Gap(28),

                      /// Title
                      Text(
                        titles[index],
                        textAlign: TextAlign.center,
                        style: FontsStyles.bold.copyWith(
                          fontSize: 22,
                          color: _accentColors[index],
                          height: 1.25,
                        ),
                      ),

                      const Gap(10),

                      /// Description
                      Text(
                        descriptions[index],
                        textAlign: TextAlign.center,
                        style: FontsStyles.regular.copyWith(
                          fontSize: 14,
                          color: Palette.black.withOpacity(0.5),
                          height: 1.6,
                        ),
                      ),

                      const Gap(32),
                    ],
                  ),
                );
              },
            ),
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _icons.length,
                  (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.only(right: 6),
                height: 6,
                width: _index == i ? 28 : 8,
                decoration: BoxDecoration(
                  color: _index == i
                      ? accent
                      : Palette.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),

          const Gap(16),

          /// Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: DefaultButton(
              bgColor: accent,
              padding: 12,
              text: _index == _icons.length - 1
                  ? AppLocalizations.of(context)!.start
                  : AppLocalizations.of(context)!.next,
              onTap: _nextPage,
            ),
          ),

          Gap(bottomPad + 32),
        ],
      ),
    );
  }
}

// ── Icône Paiement ────────────────────────────────────────────────────────────

class _PaymentIcon extends StatelessWidget {
  const _PaymentIcon();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: CustomPaint(painter: _PaymentPainter()),
    );
  }
}

class _PaymentPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final stroke = Paint()
      ..color = Palette.petrolBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;

    // Carte
    final cardRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(4, 18, size.width - 8, size.height - 36),
      const Radius.circular(10),
    );
    canvas.drawRRect(cardRect, stroke);

    // Ligne horizontale
    canvas.drawLine(
      Offset(4, 38),
      Offset(size.width - 4, 38),
      stroke,
    );

    // Rectangle petite puce
    final chipPaint = Paint()
      ..color = Palette.petrolBlue.withOpacity(0.4)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(14, 50, 20, 8),
        const Radius.circular(4),
      ),
      chipPaint,
    );

    // Cercle
    final circlePaint = Paint()
      ..color = Palette.petrolBlue.withOpacity(0.85)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width - 18, 54), 7, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Icône Taux ────────────────────────────────────────────────────────────────

class _RateIcon extends StatelessWidget {
  const _RateIcon();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: CustomPaint(painter: _RatePainter()),
    );
  }
}

class _RatePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    final ringPaint = Paint()
      ..color = Palette.orange.withOpacity(0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5;

    // Cercle principal
    canvas.drawCircle(Offset(cx, cy), 30, ringPaint);

    final handPaint = Paint()
      ..color = Palette.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Aiguille
    final path = Path()
      ..moveTo(cx, cy - 18)
      ..lineTo(cx, cy)
      ..lineTo(cx + 12, cy + 7);
    canvas.drawPath(path, handPaint);

    // Petits ticks
    final tickPaint = Paint()
      ..color = Palette.orange.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(cx - 30, cy), Offset(cx - 22, cy), tickPaint);
    canvas.drawLine(Offset(cx + 22, cy), Offset(cx + 30, cy), tickPaint);
    canvas.drawLine(Offset(cx, cy - 30), Offset(cx, cy - 22), tickPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}