import 'package:corrispay/app/design/palette.dart';
import 'package:corrispay/features/bases/widgets/default_button.dart';
import 'package:corrispay/features/beneficiary/providers/beneficiary.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../app/design/assets/assets_icons.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/routes/routes_names.dart';
import '../../../core/local/userlocal_provider.dart';
import '../../../core/utils/functions.dart';
import '../../../l10n/app_localizations.dart';
import '../../beneficiary/dto/check_qr_code_info_dto.dart';
import '../../beneficiary/models/beneficiary.model.dart';
import '../../transactions/dto/create_intern_transaction.dto.dart';
import '../../transactions/models/check_qr_code_transfer_info_model.dart';
import '../../transactions/providers/transactions_providers.dart';
import 'package:image_picker/image_picker.dart';

class QrScanScreen extends ConsumerStatefulWidget {
  const QrScanScreen({super.key});

  @override
  ConsumerState<QrScanScreen> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends ConsumerState<QrScanScreen> {
  late final MobileScannerController _controller;
  bool _isProcessing = false;
  bool _flashOn = false;

  @override
  void initState() {
    super.initState();
    _controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_isProcessing) return;

    final code = capture.barcodes.firstOrNull?.rawValue;
    if (code == null || code.isEmpty) return;

    _isProcessing = true;
    await _controller.stop();
    if (!mounted) return;

    // ── Format "montant,idDestinataire" ──
    if (code.contains(',')) {
      await _handleAmountQrCode(code);
      return;
    }

    // ── Format "idBénéficiaire" seul ──
    if (_looksLikeValidId(code)) {
      await _handleBeneficiaryQrCode(code);
      return;
    }

    // ── Ni l'un ni l'autre : QR non reconnu ──
    await showDialog(
      context: context,
      builder: (_) => const UnrecognizedQrDialog(),
    );
    _isProcessing = false;
    await _controller.start();
  }

  /// Validation basique — ajuste selon le vrai format de tes ids
  /// bénéficiaire (UUID, longueur fixe, etc.) pour éviter de tenter un
  /// appel réseau sur un contenu de QR manifestement invalide.
  bool _looksLikeValidId(String code) {
    return code.trim().isNotEmpty && !code.contains(' ') && code.length >= 6;
  }

  Future<void> _handleAmountQrCode(String code) async {
    showSuccessMessage(code);
    final parsed = parseInput(code); // conserve ta logique existante
    showLoading();
    final response = await ref.read(
      checkQrCodeInfoProvider(
        CheckQrCodeInfoDto(
          receiverId: parsed.customerId,
          amount: parsed.amount,
        ),
      ).future,
    );
    hideLoading();
    if (!mounted) return;

    if (response != null && response.status && response.data != null) {
      await showModalBottomSheet(
        isDismissible: false,
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => QrTransferConfirmBottomSheet(
          response: response.data!,
          onCancel: () async {
            _isProcessing = false;
            await _controller.start();
          },
        ),
      );
    } else {
      showErrorMessage(response?.message);
      _isProcessing = false;
      await _controller.start();
    }
  }

  Future<void> _handleBeneficiaryQrCode(String code) async {
    showLoading();
    final response = await ref.read(
      checkBeneficiaryByQrCodeProvider(code).future,
    );
    hideLoading();
    if (!mounted) return;

    if (response?.status == true && response?.data != null) {
      final beneficiary = await showModalBottomSheet<Beneficiary>(
        isDismissible: false,
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) =>
            BeneficiaryConfirmBottomSheet(beneficiary: response!.data!),
      );

      if (!mounted) return;

      if (beneficiary != null && Navigator.canPop(context)) {
        Navigator.of(context).pop(beneficiary);
        return;
      }
    } else {
      showErrorMessage(response?.message);
    }

    _isProcessing = false;
    await _controller.start();
  }

  Future<void> _toggleFlash() async {
    await _controller.toggleTorch();
    setState(() => _flashOn = !_flashOn);
  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return; // l'utilisateur a annulé

    if (_isProcessing) return;
    _isProcessing = true;
    await _controller.stop(); // pause la caméra pendant l'analyse

    try {
      final capture = await _controller.analyzeImage(pickedFile.path);
      final code = capture?.barcodes.firstOrNull?.rawValue;

      if (code == null || code.isEmpty) {
        if (!mounted) return;
        await showDialog(
          context: context,
          builder: (_) => const UnrecognizedQrDialog(),
        );
        _isProcessing = false;
        await _controller.start();
        return;
      }

      if (code.contains(',')) {
        await _handleAmountQrCode(code);
      } else if (_looksLikeValidId(code)) {
        await _handleBeneficiaryQrCode(code);
      } else {
        if (!mounted) return;
        await showDialog(
          context: context,
          builder: (_) => const UnrecognizedQrDialog(),
        );
        _isProcessing = false;
        await _controller.start();
      }
    } catch (e) {
      if (!mounted) return;
      await showDialog(
        context: context,
        builder: (_) => const UnrecognizedQrDialog(),
      );
      _isProcessing = false;
      await _controller.start();
    }
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (!didPop && Navigator.canPop(context)) {
            Navigator.of(context).pop();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                // ── Header ──
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 22, 20, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RoundedIconButton(
                            icon: Icons.arrow_back,
                            onTap: () {
                              if (Navigator.canPop(context))
                                Navigator.of(context).pop();
                            },
                          ),
                          RoundedIconButton(
                            icon: _flashOn
                                ? Icons.flash_on_rounded
                                : Icons.flash_off_rounded,
                            onTap: _toggleFlash,
                          ),
                        ],
                      ),
                      const Gap(4),
                      Text(
                        tr.quickPayment,
                        style: FontsStyles.bold.copyWith(
                          fontSize: 20,
                          color: Colors.black,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        tr.qr_scan_unified_description,
                        style: FontsStyles.regular.copyWith(
                          fontSize: 12.5,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Zone caméra ──
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: Container(
                        color: const Color(0xFF0A2E33),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            MobileScanner(
                              controller: _controller,
                              onDetect: _onDetect,
                            ),
                            const Center(child: _ScannerCorners()),
                            Positioned(
                              bottom: 16,
                              left: 0,
                              right: 0,
                              child: Text(
                                tr.qr_scan_align_hint,
                                textAlign: TextAlign.center,
                                style: FontsStyles.regular.copyWith(
                                  color: Colors.white.withOpacity(0.55),
                                  fontSize: 11.5,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                  child: GestureDetector(
                    onTap: _pickImageFromGallery,
                    child: DefaultButton(
                      iconColor: Palette.white,
                      suffixIcon: AssetsIcons.gallery,
                      padding: 16,
                      text: tr.choose_from_gallery,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Les 4 coins blancs du cadre de visée.
class _ScannerCorners extends StatelessWidget {
  const _ScannerCorners();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190,
      height: 190,
      child: Stack(
        children: [
          _corner(alignment: Alignment.topLeft),
          _corner(alignment: Alignment.topRight),
          _corner(alignment: Alignment.bottomLeft),
          _corner(alignment: Alignment.bottomRight),
        ],
      ),
    );
  }

  Widget _corner({required Alignment alignment}) {
    final isTop = alignment.y < 0;
    final isLeft = alignment.x < 0;

    return Align(
      alignment: alignment,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          border: Border(
            top: isTop
                ? const BorderSide(color: Colors.white, width: 2.5)
                : BorderSide.none,
            bottom: !isTop
                ? const BorderSide(color: Colors.white, width: 2.5)
                : BorderSide.none,
            left: isLeft
                ? const BorderSide(color: Colors.white, width: 2.5)
                : BorderSide.none,
            right: !isLeft
                ? const BorderSide(color: Colors.white, width: 2.5)
                : BorderSide.none,
          ),
          borderRadius: BorderRadius.only(
            topLeft: isTop && isLeft ? const Radius.circular(6) : Radius.zero,
            topRight: isTop && !isLeft ? const Radius.circular(6) : Radius.zero,
            bottomLeft: !isTop && isLeft
                ? const Radius.circular(6)
                : Radius.zero,
            bottomRight: !isTop && !isLeft
                ? const Radius.circular(6)
                : Radius.zero,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Bouton icône rond réutilisable (remplace RoundedBackButton,
// généralisé pour le bouton flash aussi).
// ─────────────────────────────────────────────

class RoundedIconButton extends StatelessWidget {
  const RoundedIconButton({super.key, required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFF7F8F9),
        ),
        child: Icon(icon, size: 16, color: Colors.black87),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Dialog QR non reconnu (fusion des deux anciens dialogs)
// ─────────────────────────────────────────────

class UnrecognizedQrDialog extends StatelessWidget {
  const UnrecognizedQrDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                color: Color(0xFFFFF0F0),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.qr_code_2_rounded,
                color: Color(0xFFE04040),
                size: 26,
              ),
            ),
            const Gap(16),
            Text(
              tr.unrecognized_qr_title,
              style: FontsStyles.bold.copyWith(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const Gap(8),
            Text(
              tr.unrecognized_qr_description,
              style: FontsStyles.regular.copyWith(
                fontSize: 12,
                color: Colors.grey.shade500,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(20),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Palette.petrolBlue,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Text(
                  tr.understood,
                  textAlign: TextAlign.center,
                  style: FontsStyles.bold.copyWith(
                    fontSize: 14,
                    color: Palette.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Bottom sheet confirmation bénéficiaire (inchangé, réutilisé tel quel)
// ─────────────────────────────────────────────

class BeneficiaryConfirmBottomSheet extends ConsumerWidget {
  const BeneficiaryConfirmBottomSheet({super.key, required this.beneficiary});
  final Beneficiary beneficiary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = AppLocalizations.of(context)!;
    final bottom = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.fromLTRB(24, 16, 24, bottom + 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const Gap(24),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Palette.petrolBlue.withOpacity(0.10),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.shield_outlined,
              size: 26,
              color: Palette.petrolBlue,
            ),
          ),
          const Gap(16),
          Text(
            tr.verification,
            style: FontsStyles.bold.copyWith(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const Gap(4),
          Text(
            tr.confirm_beneficiary_text,
            style: FontsStyles.regular.copyWith(
              fontSize: 12,
              color: Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF4FAF9),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Palette.petrolBlue.withOpacity(0.12),
                width: 0.5,
              ),
            ),
            child: Column(
              children: [
                BeneficiaryInfoRow(
                  label: tr.completed_name,
                  value: '${beneficiary.firstName} ${beneficiary.lastName}',
                ),
                Divider(height: 1, color: Colors.grey.shade200),
                BeneficiaryInfoRow(
                  label: tr.account,
                  value: beneficiary.phoneNumber,
                ),
              ],
            ),
          ),
          const Gap(20),
          DefaultButton(
            hPadding: 14,
            bgColor: Palette.petrolBlue,
            text: tr.correct_information,
            onTap: () => Navigator.pushNamed(
              context,
              RoutesNames.sendMoneyAfterScan,
              arguments: beneficiary,
            ),
          ),
          const Gap(10),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFE04040).withOpacity(0.07),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Text(
                tr.not_correct,
                textAlign: TextAlign.center,
                style: FontsStyles.bold.copyWith(
                  fontSize: 14,
                  color: const Color(0xFFE04040),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BeneficiaryInfoRow extends StatelessWidget {
  const BeneficiaryInfoRow({
    super.key,
    required this.label,
    required this.value,
  });
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: FontsStyles.regular.copyWith(
              fontSize: 12,
              color: Colors.grey.shade500,
            ),
          ),
          Text(value, style: FontsStyles.bold.copyWith(fontSize: 13)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Bottom sheet confirmation transfert avec montant (inchangé)
// ─────────────────────────────────────────────

class QrTransferConfirmBottomSheet extends ConsumerWidget {
  const QrTransferConfirmBottomSheet({
    super.key,
    required this.response,
    required this.onCancel,
  });

  final CheckQrCodeTransferInfoModel response;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userLocalProvider);
    final tr = AppLocalizations.of(context)!;
    final currency = user?.targetCurrency ?? '';
    final bottom = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.fromLTRB(24, 16, 24, bottom + 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const Gap(24),
          Text(
            tr.payment_request,
            style: FontsStyles.bold.copyWith(
              fontSize: 10,
              color: Palette.petrolBlue,
              letterSpacing: 1.0,
            ),
          ),
          const Gap(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                response.amount.toStringAsFixed(0),
                style: FontsStyles.bold.copyWith(
                  fontSize: 40,
                  color: Colors.black,
                  letterSpacing: -2,
                  height: 1,
                ),
              ),
              const Gap(6),
              Text(
                currency,
                style: FontsStyles.regular.copyWith(
                  fontSize: 16,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
          const Gap(20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF4FAF9),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Palette.petrolBlue.withOpacity(0.12),
                width: 0.5,
              ),
            ),
            child: Column(
              children: [
                QrTransferInfoRow(
                  label: tr.recipient,
                  value:
                      '${response.receiverFirstname} ${response.receiverLastname}',
                ),
                Divider(height: 1, color: Colors.grey.shade200),
                QrTransferInfoRow(
                  label: tr.account,
                  value: response.receiverAccountNumber,
                ),
                Divider(height: 1, color: Colors.grey.shade200),
                QrTransferInfoRow(
                  label: tr.amount_request,
                  value: '${response.amount.toStringAsFixed(0)} $currency',
                  valueColor: Palette.petrolBlue,
                ),
              ],
            ),
          ),
          const Gap(20),
          DefaultButton(
            hPadding: 14,
            bgColor: Palette.petrolBlue,
            text: tr.confirm,
            onTap: () async {
              showLoading();
              final request = await ref.read(
                createInternTransactionProvider(
                  CreateInternTransactionDto(
                    amount: response.amount,
                    to: response.receiverId,
                  ),
                ).future,
              );
              hideLoading();
              if (!context.mounted) return;

              if (request != null &&
                  request.status == true &&
                  request.data != null) {
                Navigator.pushNamed(
                  context,
                  RoutesNames.confirmSendMoney,
                  arguments: request.data,
                );
              } else {
                showErrorMessage(request?.message);
              }
            },
          ),
          const Gap(10),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              onCancel();
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFE04040).withOpacity(0.07),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Text(
                tr.cancel,
                textAlign: TextAlign.center,
                style: FontsStyles.bold.copyWith(
                  fontSize: 14,
                  color: const Color(0xFFE04040),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QrTransferInfoRow extends StatelessWidget {
  const QrTransferInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: FontsStyles.regular.copyWith(
              fontSize: 12,
              color: Colors.grey.shade500,
            ),
          ),
          Text(
            value,
            style: FontsStyles.bold.copyWith(
              fontSize: 13,
              color: valueColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
