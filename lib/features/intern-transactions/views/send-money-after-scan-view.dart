import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:corrispay/app/design/palette.dart';
import 'package:corrispay/app/routes/routes_names.dart';
import 'package:corrispay/core/local/userlocal_provider.dart';
import 'package:corrispay/core/utils/functions.dart';
import 'package:corrispay/features/bases/widgets/default_button.dart';
import 'package:corrispay/features/transactions/dto/create_intern_transaction.dto.dart';
import 'package:corrispay/features/transactions/providers/transactions_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../l10n/app_localizations.dart';
import '../../beneficiary/models/beneficiary.model.dart';

const _petrol = Palette.petrolBlue;

class SendMoneyAfterScanView extends ConsumerStatefulWidget {
  const SendMoneyAfterScanView({super.key, required this.beneficiary});
  final Beneficiary beneficiary;

  @override
  ConsumerState<SendMoneyAfterScanView> createState() =>
      _SendMoneyAfterScanViewState();
}

class _SendMoneyAfterScanViewState
    extends ConsumerState<SendMoneyAfterScanView> {
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  bool get _isFormValid =>
      _amountController.text.isNotEmpty &&
          double.tryParse(_amountController.text) != null &&
          double.parse(_amountController.text) > 0;

  Future<void> submitForm() async {
    showLoading();
    final response = await ref.read(
      createInternTransactionProvider(
        CreateInternTransactionDto(
          amount: double.parse(_amountController.text),
          to: widget.beneficiary.id,
        ),
      ).future,
    );
    hideLoading();
    if (!mounted) return;

    if (response != null && response.status && response.data != null) {
      Navigator.pushNamed(
        context,
        RoutesNames.confirmSendMoney,
        arguments: response.data,
      );
    } else {
      showErrorMessage(response?.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    final user = ref.watch(userLocalProvider);
    final b = widget.beneficiary;
    final bottomPad = MediaQuery.of(context).padding.bottom;

    return Scaffold(
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
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: _RoundedBackButton(
            onTap: () => Navigator.pop(context),
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
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ── Label destinataire ──────────────────────
                  Text(
                    tr.recipient_label.toUpperCase(),
                    style: FontsStyles.bold.copyWith(
                      fontSize: 10,
                      color: Colors.grey.shade400,
                      letterSpacing: 1.4,
                    ),
                  ),

                  const Gap(8),

                  // ── Card bénéficiaire ───────────────────────
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4FAF9),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _petrol.withOpacity(0.12),
                        width: 0.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Avatar initiales
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: _petrol,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: Text(
                              '${b.firstName[0]}${b.lastName[0]}'
                                  .toUpperCase(),
                              style: FontsStyles.bold.copyWith(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const Gap(12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${b.firstName} ${b.lastName}',
                                style: FontsStyles.bold.copyWith(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              const Gap(3),
                              Text(
                                b.phoneNumber,
                                style: FontsStyles.regular.copyWith(
                                  fontSize: 11,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Badge vérifié
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _petrol.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.check_circle_outline_rounded,
                                  size: 12, color: _petrol),
                              const Gap(4),
                              Text(
                                tr.verified,
                                style: FontsStyles.bold.copyWith(
                                  fontSize: 10,
                                  color: _petrol,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Gap(24),

                  // ── Label montant ───────────────────────────
                  Text(
                    tr.amount_label.toUpperCase(),
                    style: FontsStyles.bold.copyWith(
                      fontSize: 10,
                      color: Colors.grey.shade400,
                      letterSpacing: 1.4,
                    ),
                  ),

                  const Gap(8),

                  // ── Bloc saisie montant ─────────────────────
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: const Color(0xFFEBEBEB), width: 0.5),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: IntrinsicWidth(
                              child: TextField(
                                controller: _amountController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                textAlign: TextAlign.left,
                                cursorColor: _petrol,
                                cursorHeight: 42,
                                style: FontsStyles.bold.copyWith(
                                  fontSize: 48,
                                  color: Colors.black,
                                  letterSpacing: -3,
                                  height: 1,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '0',
                                  hintStyle: FontsStyles.bold.copyWith(
                                    fontSize: 48,
                                    color: const Color(0xFFDEDEDE),
                                    letterSpacing: -3,
                                    height: 1,
                                  ),
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                onChanged: (_) => setState(() {}),
                              ),
                            ),
                          ),
                        ),
                        // Badge devise
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: _petrol.withOpacity(0.09),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            user?.targetCurrency ?? 'EUR',
                            style: FontsStyles.bold.copyWith(
                              fontSize: 12,
                              color: _petrol,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Bouton bas ──────────────────────────────────────
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(20, 10, 20, bottomPad + 16),
            child: DefaultButton(
              isEnable: _isFormValid,
              onTap: _isFormValid ? submitForm : null,
              bgColor: _isFormValid ? _petrol : const Color(0xFFE5E7EB),
              text: tr.next,
              padding: 16,
              textStyle: FontsStyles.medium.copyWith(
                fontSize: 15,
                color: _isFormValid ? Colors.white : const Color(0xFFB0B8C1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Bouton retour rond
// ─────────────────────────────────────────────

class _RoundedBackButton extends StatelessWidget {
  const _RoundedBackButton({this.onTap});
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
          child: const Icon(Icons.arrow_back, size: 18, color: Colors.black87),
        ),
      ),
    );
  }
}