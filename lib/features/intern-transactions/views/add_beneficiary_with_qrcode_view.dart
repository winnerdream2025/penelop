import 'dart:io';
import 'package:corrispay/app/design/palette.dart';
import 'package:corrispay/features/bases/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/routes/routes_names.dart';
import '../../../core/utils/functions.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/providers/auth_provider.dart';
import '../../beneficiary/models/beneficiary.model.dart';
import '../../transactions/providers/transactions_providers.dart';

const _petrol = Color(0xFF1A7A6E);

class AddBeneficiaryWithQrcodeView extends ConsumerStatefulWidget {
  const AddBeneficiaryWithQrcodeView({super.key});

  @override
  ConsumerState<AddBeneficiaryWithQrcodeView> createState() =>
      _AddBeneficiaryWithQrcodeViewState();
}

class _AddBeneficiaryWithQrcodeViewState
    extends ConsumerState<AddBeneficiaryWithQrcodeView> {
  /**
   *  QRViewController? _controller;
      final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
      bool _isProcessing = false;
      bool _flashOn = false;

      @override
      void dispose() {
      _controller?.dispose();
      super.dispose();
      }

      @override
      void reassemble() {
      super.reassemble();
      if (Platform.isAndroid) _controller?.pauseCamera();
      _controller?.resumeCamera();
      }

      Future<void> _onScanDetected(String code) async {
      if (code.contains(',')) {
      await showDialog(
      context: context,
      builder: (_) => const WrongQrCodeDialog(),
      );
      _isProcessing = false;
      _controller?.resumeCamera();
      return;
      }

      showLoading();
      final response = await ref.read(getBeneficiaryByIdProvider(code).future);
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
      Future.microtask(() {
      if (mounted && Navigator.canPop(context)) {
      Navigator.of(context).pop(beneficiary);
      }
      });
      }
      } else {
      showErrorMessage(response?.message);
      }

      _isProcessing = false;
      _controller?.resumeCamera();
      }

      void _onQRViewCreated(QRViewController controller) {
      _controller = controller;
      controller.scannedDataStream.listen((scanData) async {
      if (_isProcessing) return;
      final code = scanData.code;
      if (code == null || code.isEmpty) return;
      _isProcessing = true;
      await controller.pauseCamera();
      if (!mounted) return;
      WidgetsBinding.instance
      .addPostFrameCallback((_) => _onScanDetected(code));
      });
      }

      void _onPermissionSet(
      BuildContext context, QRViewController ctrl, bool hasPermission) {
      final tr = AppLocalizations.of(context)!;
      if (!hasPermission) {
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(tr.camera_permission_denied)),
      );
      }
      }

      void _toggleFlash() {
      _controller?.toggleFlash();
      setState(() => _flashOn = !_flashOn);
      }
   */

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;
    final cutOut = (screenWidth - 120).clamp(220.0, 280.0);

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
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.5),
              child: Container(color: const Color(0xFFF0F0F0), height: 0.5),
            ),
            // ── Bouton retour rond gris clair ──────────────
            leading: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: RoundedBackButton(
                onTap: () {
                  if (Navigator.canPop(context)) Navigator.of(context).pop();
                },
              ),
            ),
            title: Text(
              tr.sendMoney,
              style: FontsStyles.bold.copyWith(
                color: Colors.black,
                fontSize: 16,
                letterSpacing: -0.3,
              ),
            ),
            // ── Bouton flash ───────────────────────────────
            /**
             *  actions: [
                Padding(
                padding: const EdgeInsets.only(right: 16),
                child: GestureDetector(
                onTap: _toggleFlash,
                child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade100,
                ),
                child: Icon(
                _flashOn
                ? Icons.flash_on_rounded
                : Icons.flash_off_rounded,
                size: 18,
                color: Colors.black87,
                ),
                ),
                ),
                ),
                ],
             */
          ),
          /**
           *  body: Column(
              children: [
              // ── Zone caméra ──────────────────────────────
              Expanded(
              child: Stack(
              children: [
              QRView(
              key: _qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
              // Corners pétrole
              borderColor: _petrol,
              borderRadius: 7,
              borderLength: 24,
              borderWidth: 3,
              cutOutSize: cutOut,
              overlayColor: Colors.black.withOpacity(0.55),
              ),
              onPermissionSet: (ctrl, p) =>
              _onPermissionSet(context, ctrl, p),
              ),

              // ── Hint centré au-dessus du cadre ───────
              Positioned(
              top: 28,
              left: 0,
              right: 0,
              child: Text(
              tr.qr_scan_instruction,
              textAlign: TextAlign.center,
              style: FontsStyles.regular.copyWith(
              color: Colors.white.withOpacity(0.50),
              fontSize: 13,
              letterSpacing: -0.1,
              ),
              ),
              ),
              ],
              ),
              ),

              // ── Bandeau bas blanc ────────────────────────
              Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
              child: Column(
              children: [
              // Bannière sécurité pétrole clair
              Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
              horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
              color: const Color(0xFFF0FAF8),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
              color: _petrol.withOpacity(0.18),
              width: 0.5,
              ),
              ),
              child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const Icon(
              Icons.shield_outlined,
              size: 16,
              color: _petrol,
              ),
              const Gap(10),
              Expanded(
              child: Text(
              tr.qr_scan_simple_warning,
              style: FontsStyles.regular.copyWith(
              fontSize: 12,
              color: const Color(0xFF2A5A52),
              height: 1.55,
              ),
              ),
              ),
              ],
              ),
              ),
              const Gap(12),
              // Home indicator
              Container(
              width: 100,
              height: 4,
              decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
              ),
              ),
              const Gap(4),
              ],
              ),
              ),
              ],
              ),
           */
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Bouton retour rond (composant existant)
// ─────────────────────────────────────────────

class RoundedBackButton extends StatelessWidget {
  const RoundedBackButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: onTap ?? () => Navigator.pop(context),
        child: Container(
          margin: const EdgeInsets.only(top: 12),
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade100,
          ),
          child: const Icon(
            Icons.arrow_back,
            size: 18,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Popup mauvais QR code
// ─────────────────────────────────────────────

class WrongQrCodeDialog extends StatelessWidget {
  const WrongQrCodeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
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
              tr.wrong_qr_code,
              style: FontsStyles.bold.copyWith(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const Gap(8),
            Text(
              tr.wrong_qr_code_description,
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
// Bottom sheet confirmation bénéficiaire
// ─────────────────────────────────────────────

class BeneficiaryConfirmBottomSheet extends ConsumerWidget {
  const BeneficiaryConfirmBottomSheet(
      {super.key, required this.beneficiary});
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
          // Drag handle
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
              color: _petrol.withOpacity(0.10),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.shield_outlined,
              size: 26,
              color: _petrol,
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
            padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF4FAF9),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _petrol.withOpacity(0.12),
                width: 0.5,
              ),
            ),
            child: Column(
              children: [
                BeneficiaryInfoRow(
                  label: tr.completed_name,
                  value:
                  '${beneficiary.firstName} ${beneficiary.lastName}',
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

// ─────────────────────────────────────────────
// Row info bénéficiaire
// ─────────────────────────────────────────────

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
          Text(
            value,
            style: FontsStyles.bold.copyWith(fontSize: 13),
          ),
        ],
      ),
    );
  }
}