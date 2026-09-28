import 'package:corrispay/app/design/assets/assets_ressources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashComponent extends ConsumerStatefulWidget {
  const SplashComponent({super.key});

  @override
  ConsumerState<SplashComponent> createState() => _SplashComponentState();
}

class _SplashComponentState extends ConsumerState<SplashComponent>
    with TickerProviderStateMixin {
  static const String _appName = 'CaurisPay';

  late final AnimationController _logoController;
  late final Animation<double> _logoScale;
  late final Animation<double> _logoOpacity;

  late final AnimationController _textController;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _logoScale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    // ── Animation du texte : une lettre apparaît à la fois ──
    _textController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 70 * _appName.length),
    );

    _runEntranceAnimations();
    // _initializeApp();
  }

  Future<void> _runEntranceAnimations() async {
    await _logoController.forward();
    if (!mounted) return;
    await _textController.forward();
  }



  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Logo animé ──
          AnimatedBuilder(
            animation: _logoController,
            builder: (context, child) {
              return Opacity(
                opacity: _logoOpacity.value,
                child: Transform.scale(scale: _logoScale.value, child: child),
              );
            },
            child: SizedBox(
              width: 44,
              height: 44,
              child: Image.asset(
                AssetsRessources.caurisPayLogoSquare,
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // ── Texte animé lettre par lettre ──
          AnimatedBuilder(
            animation: _textController,
            builder: (context, child) {
              final lettersToShow = (_textController.value * _appName.length)
                  .floor();
              final visibleText = _appName.substring(0, lettersToShow);

              return Text(
                visibleText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
