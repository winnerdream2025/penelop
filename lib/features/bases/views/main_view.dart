import 'package:corrispay/app/design/assets/assets_icons.dart';
import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:corrispay/app/design/palette.dart';
import 'package:corrispay/features/account/views/account_view.dart';
import 'package:corrispay/features/requests/views/request_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/local/userlocal_provider.dart';
import '../../merchant/views/merchant-dashboard-view.dart';
import '../models/dashboard_data.dart';
import 'home_view.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key, required this.data});
  final DashboardData? data;

  @override
  ConsumerState<MainView> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userLocalProvider);
    final _navItems = [
      FloatingNavItem(iconAsset: AssetsIcons.home, label: 'Accueil'),
      FloatingNavItem(
        iconAsset: AssetsIcons.requests,
        label: 'Demandes',
        showDot: true,
      ),
      if (user != null && user.hasMerchantAccount==true)
        FloatingNavItem(iconAsset: AssetsIcons.buisness, label: 'Marchant'),
      FloatingNavItem(iconAsset: AssetsIcons.user, label: 'Profil'),
    ];

    return Scaffold(
      backgroundColor: Palette.white,
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: [
              HomeView(
                data: widget.data,
                goGoMerchantSpace: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
              ),
              RequestsView(),
              if (user != null && user.hasMerchantAccount==true)
                MerchantDashboardView(
                  balance: widget.data?.merchantBalance ?? 0,
                ),
              AccountView(),
            ],
          ),

          Positioned(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).padding.bottom + 16,
            child: FloatingNavBar(
              items: _navItems,
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
            ),
          ),
        ],
      ),
    );
  }
}

/// Placeholder temporaire — à remplacer par les vrais écrans.
class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        label,
        style: const TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// FloatingNavBar — style Revolut (icône + label), version flottante
// (coins arrondis partout, ombre tout autour, marges de chaque côté).
// ─────────────────────────────────────────────

class FloatingNavItem {
  const FloatingNavItem({
    required this.iconAsset,
    required this.label,
    this.showDot = false,
  });

  /// Chemin de l'icône SVG (ex: AssetsIcons.home).
  final String iconAsset;
  final String label;

  /// Affiche un petit point orange (ex: notification en attente).
  final bool showDot;
}

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
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      decoration: BoxDecoration(
        color: Palette.petrolBlue,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final isActive = index == currentIndex;
          return GestureDetector(
            onTap: () => onTap(index),
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),

              decoration: BoxDecoration(
                color: isActive ? Color(0x29FA7900) : Colors.transparent,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SvgPicture.asset(
                        items[index].iconAsset,
                        width: 21,
                        colorFilter: ColorFilter.mode(
                          isActive ? Palette.orange : const Color(0xFFC2C2C2),
                          BlendMode.srcIn,
                        ),
                      ),
                      if (items[index].showDot && !isActive)
                        Positioned(
                          top: -3,
                          right: -5,
                          child: Container(
                            width: 7,
                            height: 7,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Palette.orange,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    items[index].label,
                    style: FontsStyles.medium.copyWith(
                      fontSize: 10,
                      color: isActive
                          ? Palette.orange
                          : const Color(0xFFC2C2C2),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
