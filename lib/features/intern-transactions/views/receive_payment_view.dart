import 'dart:io';
import 'package:corrispay/app/design/assets/assets_icons.dart';
import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:corrispay/app/design/palette.dart';
import 'package:corrispay/core/local/userlocal_provider.dart';
import 'package:corrispay/features/bases/widgets/default_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gal/gal.dart';
import 'package:gap/gap.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import '../../../l10n/app_localizations.dart';

class ReceivePaymentView extends ConsumerStatefulWidget {
  const ReceivePaymentView({super.key, required this.amount});
  final double amount;

  @override
  ConsumerState<ReceivePaymentView> createState() => _ReceivePaymentViewState();
}

class _ReceivePaymentViewState extends ConsumerState<ReceivePaymentView> {
  final ScreenshotController _screenshotController = ScreenshotController();
  bool _isDownloading = false;

  Future<void> _downloadQrCode() async {
    setState(() => _isDownloading = true);

    try {
      final Uint8List? image = await _screenshotController.capture(
        pixelRatio: 3.0,
      );

      if (image == null) return;

      if (kIsWeb) {
        // Web — à implémenter si besoin
      } else if (Platform.isAndroid || Platform.isIOS) {
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/qrcode_payment.png');
        await file.writeAsBytes(image);

        final hasAccess = await Gal.hasAccess();
        if (!hasAccess) await Gal.requestAccess();

        await Gal.putImage(file.path);
      } else {
        final dir = await getApplicationDocumentsDirectory();
        final file = File(
          '${dir.path}/qrcode_payment_${DateTime.now().millisecondsSinceEpoch}.png',
        );
        await file.writeAsBytes(image);
      }

      if (mounted) {
        final loc = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            backgroundColor: Palette.petrolBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            duration: const Duration(seconds: 3),
            content: Row(
              children: [
                const Icon(
                  Icons.check_circle_outline_rounded,
                  color: Colors.white,
                  size: 18,
                ),
                const Gap(10),
                Text(
                  loc.qr_download_success,
                  style: FontsStyles.regular.copyWith(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        final loc = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            backgroundColor: const Color(0xFFE04040),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            duration: const Duration(seconds: 3),
            content: Row(
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  color: Colors.white,
                  size: 18,
                ),
                const Gap(10),
                Expanded(
                  child: Text(
                    loc.qr_download_error,
                    style: FontsStyles.regular.copyWith(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userLocalProvider);
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Palette.white,
      appBar: AppBar(backgroundColor: Palette.white, elevation: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
          child: Column(
            children: [

              // ── Montant ───────────────────────────────────────────
              Column(
                children: [
                  Text(
                    loc.payment_request.toUpperCase(),
                    style: FontsStyles.medium.copyWith(
                      fontSize: 11,
                      color: Colors.grey.shade400,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const Gap(8),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: widget.amount.toStringAsFixed(0),
                          style: FontsStyles.bold.copyWith(
                            fontSize: 50,
                            color: Palette.black,
                            letterSpacing: -2,
                            height: 1,
                          ),
                        ),
                        TextSpan(
                          text: ' ${user?.targetCurrency ?? ''}',
                          style: FontsStyles.regular.copyWith(
                            fontSize: 20,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const Gap(24),
        
              // ── Card QR (capturée par Screenshot) ─────────────────
              Screenshot(
                controller: _screenshotController,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Container(

                    decoration: BoxDecoration(
                      color: Palette.white,
                      border: Border.all(color: const Color(0xFFF0F0F0)),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [


                        // Header orange
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 18,
                          ),
                          color: Palette.orange,
                          child: Column(
                            children: [
                              Text(
                                '${user?.firstName.toUpperCase()} ${user?.lastName.toUpperCase()}',
                                style: FontsStyles.bold.copyWith(
                                  fontSize: 14,
                                  color: Palette.white,
                                  letterSpacing: 0.3,
                                ),
                              ),
                              const Gap(4),
                              Text(
                                loc.scan_to_send(
                                  widget.amount.toStringAsFixed(0),
                                  user?.targetCurrency ?? '',
                                ),
                                style: FontsStyles.regular.copyWith(
                                  fontSize: 11,
                                  color: Palette.white.withOpacity(0.75),
                                ),
                              ),
                            ],
                          ),
                        ),
        
                        // QR code
                        Container(
                          color: Palette.white,
                          padding: const EdgeInsets.all(24),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Palette.white,
                              border: Border.all(
                                color: const Color(0xFFF0F0F0),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: QrImageView(
                              data: '${widget.amount},${user?.id}',
                              version: QrVersions.auto,
                              size: 180,
                              gapless: true,
                            ),
                          ),
                        ),
        
                        // Footer
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          color: const Color(0xFFFAFAFA),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.shield_outlined,
                                size: 14,
                                color: Palette.petrolBlue,
                              ),
                              const Gap(6),
                              Text(
                                loc.secured_by,
                                style: FontsStyles.regular.copyWith(
                                  fontSize: 11,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              Text(
                                ' Caurispay',
                                style: FontsStyles.bold.copyWith(
                                  fontSize: 11,
                                  color: Palette.petrolBlue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        
              const Gap(16),
        
              // ── Warning ───────────────────────────────────────────
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8F0),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFFFE4BE)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      AssetsIcons.warning,
                      colorFilter: const ColorFilter.mode(
                        Palette.orange,
                        BlendMode.srcIn,
                      ),
                      height: 16,
                    ),
                    const Gap(10),
                    Expanded(
                      child: Text(
                        loc.qr_code_message,
                        style: FontsStyles.regular.copyWith(
                          fontSize: 11,
                          color: const Color(0xFFa06000),
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        
              const Gap(16),
        
              // ── Bouton télécharger ────────────────────────────────
              DefaultButton(
                hPadding: 12,
                bgColor: Palette.petrolBlue,
                textStyle: FontsStyles.bold.copyWith(
                  fontSize: 15,
                  color: Palette.white,
                ),
                text: _isDownloading ? loc.downloading : loc.download,
                onTap: _isDownloading ? null : _downloadQrCode,
              ),
        
              const Gap(12),
        
              // ── Bouton terminer ───────────────────────────────────
              DefaultButton(
                hPadding: 12,
                bgColor: Colors.transparent,
                textStyle: FontsStyles.bold.copyWith(
                  fontSize: 15,
                  color: Palette.petrolBlue,
                ),
                text: loc.finish,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}