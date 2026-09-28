import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../app/design/assets/assets_icons.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';

class FloatingNavItem {
  const FloatingNavItem({
    required this.iconAsset,
    required this.label,
    this.showDot = false,
  });

  /// Chemin de l'icône SVG (ex: AssetsIcons.homeIcon).
  final String iconAsset;
  final String label;

  /// Affiche un petit point orange (ex: notification en attente).
  final bool showDot;
}

/// Barre de navigation flottante — fond blanc, l'onglet actif prend une
/// pastille arrondie teintée (icône + label), les onglets inactifs
/// restent discrets (icône seule, grise).
class FloatingNavBar extends StatelessWidget {
  const FloatingNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  final List<FloatingNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Palette.petrolBlue.withOpacity(0.1),
            blurRadius: 28,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: List.generate(items.length, (index) {
          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(index),
              behavior: HitTestBehavior.opaque,
              child: _NavTab(
                item: items[index],
                isActive: index == currentIndex,
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _NavTab extends StatelessWidget {
  const _NavTab({required this.item, required this.isActive});

  final FloatingNavItem item;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      padding: EdgeInsets.symmetric(
        horizontal: isActive ? 14 : 0,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: isActive
            ? Palette.petrolBlue.withOpacity(0.08)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              SvgPicture.asset(
                item.iconAsset,
                width: isActive ? 17 : 19,
                colorFilter: ColorFilter.mode(
                  isActive ? Palette.petrolBlue : const Color(0xFFB0B0B0),
                  BlendMode.srcIn,
                ),
              ),
              if (item.showDot && !isActive)
                Positioned(
                  top: -3,
                  right: -5,
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Palette.orange,
                    ),
                  ),
                ),
            ],
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            child: isActive
                ? Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                item.label,
                style: FontsStyles.bold.copyWith(
                  fontSize: 12,
                  color: Palette.petrolBlue,
                ),
              ),
            )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}