import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:corrispay/app/design/palette.dart';
import 'package:corrispay/app/routes/routes_names.dart';
import 'package:corrispay/core/local/merchant_account.provider.dart';
import 'package:corrispay/core/local/userlocal_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../app/design/assets/assets_icons.dart';
import '../../../app/design/assets/assets_ressources.dart';
import '../../bases/services/service.dart';
import '../../bases/widgets/default_button.dart';

class MerchantDashboardView extends ConsumerStatefulWidget {
  const MerchantDashboardView({super.key, required this.balance});
  final double balance;

  @override
  ConsumerState<MerchantDashboardView> createState() =>
      _MerchantDashboardViewState();
}

class _MerchantDashboardViewState extends ConsumerState<MerchantDashboardView> {
  bool _isBalanceHidden = false;
  final _socketService = SocketService();
  double balance = 0;

  @override
  void initState() {
    super.initState();

    balance = widget.balance;

    SocketService().listenMerchantBalance((data) {
      final newBalance = (data['balance'] as num).toDouble();
      if (mounted) {
        setState(() => balance = newBalance);
      }
    });
  }

  @override
  void dispose() {
    SocketService().stopListeningMerchantBalance();
    super.dispose();
  }

  void _toggleBalanceVisibility() {
    setState(() => _isBalanceHidden = !_isBalanceHidden);
  }

  Future<void> _copyCode(String merchantCode) async {
    await Clipboard.setData(ClipboardData(text: merchantCode));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Palette.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle_rounded,
              color: Colors.white,
              size: 18,
            ),
            const Gap(8),
            Text(
              'Matricule copié',
              style: FontsStyles.medium.copyWith(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  String _formattedBalance(double balance) {
    final formatter = NumberFormat.currency(
      locale: 'fr_FR',
      symbol: '',
      decimalDigits: 2,
    );
    return formatter.format(balance);
  }

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;
    final merchantAccount = ref.watch(merchantAccountLocalProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F9),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ).copyWith(top: topPad + 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header : label + nom + matricule ──
            Text(
              'MON COMPTE',
              style: FontsStyles.bold.copyWith(
                fontSize: 10.5,
                color: Colors.grey.shade400,
                letterSpacing: 2,
              ),
            ),
            const Gap(6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Expanded(
                  child: Text(
                    merchantAccount?.designation ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: FontsStyles.bold.copyWith(
                      fontSize: 20,
                      color: Palette.black,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
                const Gap(10),
                GestureDetector(
                  onTap: () {
                    final code = merchantAccount?.merchantCode;
                    if (code != null && code.toString().isNotEmpty) {
                      _copyCode(code.toString());
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Text(
                      merchantAccount?.merchantCode ?? "",
                      style: FontsStyles.regular.copyWith(
                        fontSize: 10.5,
                        color: Colors.grey.shade500,
                        letterSpacing: 0.2,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(20),

                    // ── Carte solde ──
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 24,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Palette.orange,
                            Palette.orange.withOpacity(0.85),
                          ],
                        ),
                      ),
                      child: Stack(
                        children: [
                          // Motif décoratif discret en arrière-plan
                          Positioned(
                            right: -30,
                            top: -30,
                            child: Opacity(
                              opacity: 0.08,
                              child: Image.asset(
                                AssetsRessources.icon,
                                width: 160,
                                height: 160,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Solde disponible',
                                    style: FontsStyles.regular.copyWith(
                                      fontSize: 12,
                                      color: Colors.white.withOpacity(0.75),
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: _toggleBalanceVisibility,
                                    behavior: HitTestBehavior.opaque,
                                    child: Icon(
                                      _isBalanceHidden
                                          ? Icons.visibility_off_rounded
                                          : Icons.visibility_rounded,
                                      size: 18,
                                      color: Colors.white.withOpacity(0.85),
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 200),
                                    child: Text(
                                      _isBalanceHidden
                                          ? '•••••'
                                          : _formattedBalance(balance),
                                      key: ValueKey(_isBalanceHidden),
                                      style: FontsStyles.black.copyWith(
                                        fontSize: 32,
                                        color: Colors.white,
                                        letterSpacing: _isBalanceHidden
                                            ? 3
                                            : -0.8,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                  const Gap(6),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 3),
                                    child: Text(
                                      'FCFA',
                                      style: FontsStyles.medium.copyWith(
                                        fontSize: 12,
                                        color: Colors.white.withOpacity(0.75),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(22),
                              SizedBox(
                                width: double.infinity,
                                child: DefaultButton(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RoutesNames.internTransferView,
                                    );
                                  },
                                  icon: AssetsIcons.add,
                                  hPadding: 16,
                                  padding: 13,
                                  iconColor: Palette.petrolBlue,
                                  bgColor: Colors.white,
                                  textColor: Palette.petrolBlue,
                                  textStyle: FontsStyles.medium.copyWith(
                                    fontSize: 13.5,
                                    color: Palette.petrolBlue,
                                  ),
                                  text: "Transférer",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Gap(24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
