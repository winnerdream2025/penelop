import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../app/design/fonts_styles.dart';
import '../../main.dart';
// import ton navigatorKey existant, ex:
// import 'navigation.dart';


// ── Machinerie interne — affichage en haut via Overlay ─────────────
//
// Un SnackBar est TOUJOURS ancré en bas en Flutter (limitation native
// du widget, pas configurable via `behavior`/`margin`). Pour l'afficher
// en haut, il faut passer par un OverlayEntry positionné manuellement,
// avec sa propre animation d'entrée/sortie.

void showTopToast({
  required String message,
  required Color backgroundColor,
  required IconData icon,
  Duration duration = const Duration(seconds: 3),
}) {
  final overlayState = navigatorKey.currentState?.overlay;
  if (overlayState == null) return;

  late OverlayEntry entry;
  final controller = _TopToastController();

  entry = OverlayEntry(
    builder: (context) => _TopToastWidget(
      message: message,
      backgroundColor: backgroundColor,
      icon: icon,
      controller: controller,
      onDismissed: () => entry.remove(),
    ),
  );

  overlayState.insert(entry);

  Future.delayed(duration, () => controller.dismiss());
}

class _TopToastController {
  VoidCallback? _dismissCallback;
  void _attach(VoidCallback dismiss) => _dismissCallback = dismiss;
  void dismiss() => _dismissCallback?.call();
}

class _TopToastWidget extends StatefulWidget {
  const _TopToastWidget({
    required this.message,
    required this.backgroundColor,
    required this.icon,
    required this.controller,
    required this.onDismissed,
  });

  final String message;
  final Color backgroundColor;
  final IconData icon;
  final _TopToastController controller;
  final VoidCallback onDismissed;

  @override
  State<_TopToastWidget> createState() => _TopToastWidgetState();
}

class _TopToastWidgetState extends State<_TopToastWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _anim;
  late final Animation<Offset> _slide;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    widget.controller._attach(_dismiss);

    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _anim, curve: Curves.easeOutCubic));
    _fade = CurvedAnimation(parent: _anim, curve: Curves.easeOut);

    _anim.forward();
  }

  Future<void> _dismiss() async {
    if (!mounted) return;
    await _anim.reverse();
    widget.onDismissed();
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 12,
      left: 16,
      right: 16,
      child: SlideTransition(
        position: _slide,
        child: FadeTransition(
          opacity: _fade,
          child: Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: _dismiss,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(widget.icon, color: Colors.white, size: 18),
                    const Gap(10),
                    Expanded(
                      child: Text(
                        widget.message,
                        style: FontsStyles.regular.copyWith(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}