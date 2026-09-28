import 'dart:async';
import 'package:corrispay/app/design/assets/assets_ressources.dart';
import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:corrispay/app/design/palette.dart';
import 'package:corrispay/app/routes/routes_names.dart';
import 'package:corrispay/core/utils/functions.dart';
import 'package:corrispay/features/bases/widgets/default_button.dart';
import 'package:corrispay/features/bases/services/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../../../app/design/assets/assets_icons.dart';
import '../../transactions/models/payment_request_summary.dart';
import '../../transactions/screens/payment-request-banner.dart';
import '../models/dashboard_data.dart';
import '../../../core/local/userlocal_provider.dart';
import '../../../l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../screens/comming_bottom_sheet.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key, required this.data, required this.goGoMerchantSpace});
  final DashboardData? data;
  final VoidCallback goGoMerchantSpace;


  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final _socketService = SocketService();
  double balance = 0;
  Timer? _expiryTimer;

  // Contrôle l'affichage du solde (masqué / visible)
  bool _isBalanceHidden = false;

  @override
  void initState() {
    super.initState();

    if (widget.data != null) {
      balance = widget.data!.balance;

    }

    _socketService.connect().then((_) {
      _listenBalance();

    });


  }


  void _listenBalance() {
    _socketService.listenBalance((data) {
      if (!mounted) return;
      setState(() {
        balance = double.parse(data['balance'].toString());
      });
    });
  }



  void _toggleBalanceVisibility() {
    setState(() {
      _isBalanceHidden = !_isBalanceHidden;
    });
  }

  @override
  void dispose() {
    _socketService.stopListeningNewRequest();
    _expiryTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final user = ref.watch(userLocalProvider);

    if (user == null) {
      return Scaffold(
        body: Center(
          child: Text(
            loc.common_error,
            style: FontsStyles.regular.copyWith(color: Colors.grey.shade500),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Palette.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
        ).copyWith(top: MediaQuery.of(context).padding.top + 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Palette.petrolBlue,
                        child: Text(
                          user.firstName[0].toUpperCase(),
                          style: FontsStyles.bold.copyWith(
                            color: Palette.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Gap(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            loc.hello,
                            style: FontsStyles.regular.copyWith(
                              fontSize: 12,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          Text(
                            user.firstName,
                            style: FontsStyles.bold.copyWith(
                              fontSize: 15,
                              color: Palette.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  NotificationBellButton(
                    badgeCount: 0,
                    onTap: () => Navigator.pushNamed(
                      context,
                      RoutesNames.notificationsView,
                    ),
                  ),
                ],
              ),

              const Gap(18),

              // ── Carte solde ───────────────────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                decoration: BoxDecoration(
                  color: Palette.petrolBlue,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(AssetsRessources.icon),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.04),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          loc.availableBalance,
                          style: FontsStyles.regular.copyWith(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                        GestureDetector(
                          onTap: _toggleBalanceVisibility,
                          behavior: HitTestBehavior.opaque,
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Icon(
                              _isBalanceHidden
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: 17,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(6),
                    AccountBalanceCard(
                      targetCurrency: user.targetCurrency,
                      currencyRate: user.currencyRate,
                      balance: balance,
                      isHidden: _isBalanceHidden,
                    ),
                    const Gap(16),
                    Row(
                      children: [
                        Expanded(
                          child: DefaultButton(
                            onTap: () => Navigator.pushNamed(
                              context,
                              RoutesNames.addMoneyToWallet,
                              arguments: balance,
                            ),
                            text: loc.addMoney,
                            icon: AssetsIcons.add,
                            hPadding: 16,
                            padding: 12,
                            iconColor: Palette.petrolBlue,
                            bgColor: Colors.white,
                            textColor: Palette.petrolBlue,
                            textStyle: FontsStyles.medium.copyWith(
                              fontSize: 13,
                              color: Palette.petrolBlue,
                            ),
                          ),
                        ),
                        const Gap(8),
                        Expanded(
                          child: DefaultButton(
                            onTap: () => Navigator.pushNamed(
                              context,
                              RoutesNames.scanView,
                            ),
                            text: loc.scanToPayTitle,
                            icon: AssetsIcons.scan,
                            hPadding: 16,
                            padding: 12,
                            iconColor: Colors.white,
                            bgColor: Palette.orange,
                            textColor: Colors.white,
                            textStyle: FontsStyles.medium.copyWith(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Gap(12),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HomeActionButton(
                    label: loc.simpleSend,
                    icon: AssetsIcons.send,
                    bgColor: Palette.white,
                    iconColor: Palette.orange,
                    labelColor: Palette.white,
                    borderColor: Palette.orange,
                    onTap: () => Navigator.pushNamed(
                      context,
                      RoutesNames.addAmount,
                      arguments: balance,
                    ),
                  ),
                  HomeActionButton(
                    label: loc.withdrawTo,
                    icon: AssetsIcons.exchange,
                    bgColor: Palette.white,
                    iconColor: Palette.petrolBlue,
                    labelColor: Palette.petrolBlue,
                    borderColor: Palette.petrolBlue,
                    onTap: () => Navigator.pushNamed(
                      context,
                      RoutesNames.enterWithdrawalAmount,
                      arguments: balance,
                    ),
                  ),
                  HomeActionButton(
                    label: loc.history,
                    borderColor: Palette.orange,
                    icon: AssetsIcons.history,
                    bgColor: Palette.white,
                    iconColor: Palette.orange,
                    labelColor: Palette.petrolBlue,
                    onTap: () => Navigator.pushNamed(
                      context,
                      RoutesNames.transactionView,
                    ),
                  ),
                  HomeActionButton(
                    borderColor: Palette.petrolBlue,
                    label: loc.merchant,
                    icon: AssetsIcons.store,
                    bgColor: Palette.white,
                    iconColor: Palette.petrolBlue,
                    labelColor: Palette.petrolBlue,
                    onTap: () => MerchantSpaceSheet.show(context, widget.goGoMerchantSpace),
                  ),
                ],
              ),

              const Gap(20),

              // ── Section QR code ────────────────────────────────
              Text(
                loc.qrCodeSectionTitle,
                style: FontsStyles.medium.copyWith(
                  fontSize: 13,
                  color: Palette.black,
                ),
              ),
              const Gap(10),
              QrCodeSection(
                items: [
                  QrCodeListItem(
                    icon: AssetsIcons.qrcode,
                    color: Palette.teal,
                    title: loc.qrFreeAmountTitle,
                    subtitle: loc.qrFreeAmountDesc,
                    onTap: () => Navigator.pushNamed(
                      context,
                      RoutesNames.qrCode,
                      arguments: balance,
                    ),
                  ),
                  QrCodeListItem(
                    icon: AssetsIcons.qrcode,
                    color: Palette.orange,
                    title: loc.qrFixedAmountTitle,
                    subtitle: loc.qrFixedAmountDesc,
                    onTap: () => Navigator.pushNamed(
                      context,
                      RoutesNames.enterRequestAmount,
                    ),
                  ),
                ],
              ),

              const Gap(32),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Cloche de notification avec badge
// ─────────────────────────────────────────────

class NotificationBellButton extends StatelessWidget {
  const NotificationBellButton({
    super.key,
    required this.badgeCount,
    required this.onTap,
  });

  final int badgeCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: SvgPicture.asset(AssetsIcons.notifications, width: 22),
            ),
          ),
          if (badgeCount > 0)
            Positioned(
              top: -2,
              right: -2,
              child: Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  color: Palette.orange,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    badgeCount > 9 ? '9+' : '$badgeCount',
                    style: FontsStyles.medium.copyWith(
                      fontSize: 9,
                      color: Palette.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Section QR code — liste explicite (icône + titre + description)
// ─────────────────────────────────────────────

class QrCodeListItem {
  const QrCodeListItem({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
}

class QrCodeSection extends StatelessWidget {
  const QrCodeSection({super.key, required this.items});

  final List<QrCodeListItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.white,
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          for (var i = 0; i < items.length; i++) ...[
            _QrCodeRow(item: items[i]),
            if (i != items.length - 1)
              Divider(height: 1, color: Colors.grey.shade200),
          ],
        ],
      ),
    );
  }
}

class _QrCodeRow extends StatelessWidget {
  const _QrCodeRow({required this.item});

  final QrCodeListItem item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: item.color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Center(
                child: SvgPicture.asset(
                  item.icon,
                  width: 18,
                  colorFilter: ColorFilter.mode(item.color, BlendMode.srcIn),
                ),
              ),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: FontsStyles.medium.copyWith(
                      fontSize: 13,
                      color: Palette.black,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    item.subtitle,
                    style: FontsStyles.regular.copyWith(
                      fontSize: 11,
                      color: Colors.grey.shade500,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, size: 18, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Bouton action (inchangé)
// ─────────────────────────────────────────────

class HomeActionButton extends StatelessWidget {
  const HomeActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
    required this.labelColor,
    required this.onTap,
    required this.borderColor,
  });

  final String label;
  final String icon;
  final Color bgColor;
  final Color iconColor;
  final Color labelColor;
  final VoidCallback onTap;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DefaultButton(
            padding: 16,
            raduis: 400,
            icon: icon,
            bgColor: bgColor,
            iconColor: iconColor,
            brColor: borderColor,
          ),
          const Gap(6),
          Text(
            label,
            style: FontsStyles.medium.copyWith(fontSize: 11),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Carte solde — avec masquage du solde
// ─────────────────────────────────────────────

class AccountBalanceCard extends StatelessWidget {
  const AccountBalanceCard({
    super.key,
    required this.targetCurrency,
    required this.currencyRate,
    required this.balance,
    this.isHidden = false,
  });

  final double currencyRate;
  final double balance;
  final String targetCurrency;
  final bool isHidden;

  String formatAmount(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'fr_FR',
      symbol: '',
      decimalDigits: targetCurrency == 'FCFA' ? 0 : 2,
    );
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    if (isHidden) {
      return FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: RichText(
          text: TextSpan(
            text: '•••••',
            style: FontsStyles.black.copyWith(
              color: Palette.white,
              fontSize: 38,
              letterSpacing: 2,
            ),
            children: [
              TextSpan(
                text: '  $targetCurrency',
                style: FontsStyles.regular.copyWith(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: balance),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
      builder: (context, animatedBalance, _) {
        return FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: RichText(
            text: TextSpan(
              text: formatAmount(animatedBalance),
              style: FontsStyles.black.copyWith(
                color: Palette.white,
                fontSize: 38,
              ),
              children: [
                TextSpan(
                  text: '  $targetCurrency',
                  style: FontsStyles.regular.copyWith(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
