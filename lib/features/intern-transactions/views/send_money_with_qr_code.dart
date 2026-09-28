import 'dart:io';
import 'package:corrispay/app/design/palette.dart';
import 'package:corrispay/features/bases/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/routes/routes_names.dart';
import '../../../core/local/userlocal_provider.dart';
import '../../../core/utils/functions.dart';
import '../../../l10n/app_localizations.dart';
import '../../beneficiary/dto/check_qr_code_info_dto.dart';
import '../../transactions/dto/create_intern_transaction.dto.dart';
import '../../transactions/models/check_qr_code_transfer_info_model.dart';
import '../../transactions/providers/transactions_providers.dart';


// ─────────────────────────────────────────────
// Scanner view
// ─────────────────────────────────────────────

class SendMoneyWithQrCode extends ConsumerStatefulWidget {
  const SendMoneyWithQrCode({super.key});

  @override
  ConsumerState<SendMoneyWithQrCode> createState() =>
      _SendMoneyWithQrCodeState();
}

class _SendMoneyWithQrCodeState extends ConsumerState<SendMoneyWithQrCode> {
  /**
   *   Barcode? result;
      QRViewController? controller;
      final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
      bool _isDialogShown = false;
      bool _flashOn = false;

      @override
      void reassemble() {
      super.reassemble();
      if (Platform.isAndroid) controller?.pauseCamera();
      controller?.resumeCamera();
      }

      @override
      void dispose() {
      controller?.dispose();
      super.dispose();
      }

      Future<void> submitForm(String amount, String receiverId) async {
      showLoading();
      final response = await ref.read(
      checkQrCodeInfoProvider(
      CheckQrCodeInfoDto(
      receiverId: receiverId,
      amount: double.parse(amount),
      ),
      ).future,
      );
      hideLoading();
      if (!mounted) return;

      if (response != null && response.status && response.data != null) {
      showModalBottomSheet(
      isDismissible: false,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => QrTransferConfirmBottomSheet(
      response: response.data!,
      onCancel: () async {
      _isDialogShown = false;
      await controller?.resumeCamera();
      },
      ),
      );
      } else {
      showErrorMessage(response?.message);
      _isDialogShown = false;
      controller?.resumeCamera();
      }
      }

      void onQRViewCreated(QRViewController ctrl) {
      controller = ctrl;
      ctrl.scannedDataStream.listen((scanData) async {
      if (_isDialogShown) return;

      final code = scanData.code ?? '';
      if (code.isEmpty) return;

      // ── Mauvais QR : pas de virgule ────────────────────────
      if (!code.contains(',')) {
      _isDialogShown = true;
      await ctrl.pauseCamera();
      if (!mounted) return;

      await showDialog(
      context: context,
      builder: (_) => const WrongQrTypeDialog(),
      );

      _isDialogShown = false;
      ctrl.resumeCamera();
      return;
      }

      // ── Bon QR : amount,userId ─────────────────────────────
      _isDialogShown = true;
      result = scanData;
      await ctrl.pauseCamera();
      if (!mounted) return;

      WidgetsBinding.instance.addPostFrameCallback((_) {
      final parsed = parseInput(code);
      submitForm(parsed.amount, parsed.customerId);
      });
      });
      }

      void onPermissionSet(
      BuildContext context,
      QRViewController ctrl,
      bool hasPermission,
      ) {
      if (!hasPermission) {
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Camera permission denied')),
      );
      }
      }

      void _toggleFlash() {
      controller?.toggleFlash();
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
          // ── Bouton retour rond ────────────────────────────
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
          // ── Bouton flash ──────────────────────────────────
          /**
           *   Barcode? result;
              QRViewController? controller;
              final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
              bool _isDialogShown = false;
              bool _flashOn = false;

              @override
              void reassemble() {
              super.reassemble();
              if (Platform.isAndroid) controller?.pauseCamera();
              controller?.resumeCamera();
              }

              @override
              void dispose() {
              controller?.dispose();
              super.dispose();
              }

              Future<void> submitForm(String amount, String receiverId) async {
              showLoading();
              final response = await ref.read(
              checkQrCodeInfoProvider(
              CheckQrCodeInfoDto(
              receiverId: receiverId,
              amount: double.parse(amount),
              ),
              ).future,
              );
              hideLoading();
              if (!mounted) return;

              if (response != null && response.status && response.data != null) {
              showModalBottomSheet(
              isDismissible: false,
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => QrTransferConfirmBottomSheet(
              response: response.data!,
              onCancel: () async {
              _isDialogShown = false;
              await controller?.resumeCamera();
              },
              ),
              );
              } else {
              showErrorMessage(response?.message);
              _isDialogShown = false;
              controller?.resumeCamera();
              }
              }

              void onQRViewCreated(QRViewController ctrl) {
              controller = ctrl;
              ctrl.scannedDataStream.listen((scanData) async {
              if (_isDialogShown) return;

              final code = scanData.code ?? '';
              if (code.isEmpty) return;

              // ── Mauvais QR : pas de virgule ────────────────────────
              if (!code.contains(',')) {
              _isDialogShown = true;
              await ctrl.pauseCamera();
              if (!mounted) return;

              await showDialog(
              context: context,
              builder: (_) => const WrongQrTypeDialog(),
              );

              _isDialogShown = false;
              ctrl.resumeCamera();
              return;
              }

              // ── Bon QR : amount,userId ─────────────────────────────
              _isDialogShown = true;
              result = scanData;
              await ctrl.pauseCamera();
              if (!mounted) return;

              WidgetsBinding.instance.addPostFrameCallback((_) {
              final parsed = parseInput(code);
              submitForm(parsed.amount, parsed.customerId);
              });
              });
              }

              void onPermissionSet(
              BuildContext context,
              QRViewController ctrl,
              bool hasPermission,
              ) {
              if (!hasPermission) {
              ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Camera permission denied')),
              );
              }
              }

              void _toggleFlash() {
              controller?.toggleFlash();
              setState(() => _flashOn = !_flashOn);
              }
           */
        ),
        /**
         *  body: Column(
            children: [
            // ── Zone caméra ─────────────────────────────────
            Expanded(
            child: Stack(
            children: [
            QRView(
            key: qrKey,
            onQRViewCreated: onQRViewCreated,
            overlay: QrScannerOverlayShape(
            borderColor:Palette.petrolBlue,
            borderRadius: 7,
            borderLength: 24,
            borderWidth: 3,
            cutOutSize: cutOut,
            overlayColor: Colors.black.withOpacity(0.55),
            ),
            onPermissionSet: (ctrl, p) =>
            onPermissionSet(context, ctrl, p),
            ),
            // ── Hint au-dessus du cadre ─────────────────
            Positioned(
            top: 28,
            left: 0,
            right: 0,
            child: Text(
            tr.qr_with_amount_description,
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

            // ── Bandeau bas blanc ────────────────────────────
            Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Column(
            children: [
            Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
            horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
            color: const Color(0xFFF0FAF8),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
            color: Palette.petrolBlue.withOpacity(0.18),
            width: 0.5,
            ),
            ),
            child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const Icon(
            Icons.shield_outlined,
            size: 16,
            color: Palette.petrolBlue,
            ),
            const Gap(10),
            Expanded(
            child: Text(
            tr.qr_with_amount_description,
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
    );
  }
}

// ─────────────────────────────────────────────
// Bouton retour rond
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
// Popup mauvais type de QR
// ─────────────────────────────────────────────

class WrongQrTypeDialog extends StatelessWidget {
  const WrongQrTypeDialog({super.key});

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
           tr.wrong_qr_description_amount,
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
// Bottom sheet confirmation transfert QR
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
          // ── Drag handle ───────────────────────────────────
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(4),
            ),
          ),

          const Gap(24),

          // ── Label demande ─────────────────────────────────
          Text(
            tr.payment_request,
            style: FontsStyles.bold.copyWith(
              fontSize: 10,
              color: Palette.petrolBlue,
              letterSpacing: 1.0,
            ),
          ),

          const Gap(8),

          // ── Hero montant ──────────────────────────────────
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

          // ── Bloc infos destinataire ───────────────────────
          Container(
            width: double.infinity,
            padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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

          // ── Bouton confirmer ──────────────────────────────
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

          // ── Bouton annuler ────────────────────────────────
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

// ─────────────────────────────────────────────
// Row info transfert
// ─────────────────────────────────────────────

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