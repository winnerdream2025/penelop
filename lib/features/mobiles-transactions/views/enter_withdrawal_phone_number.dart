import 'package:corrispay/core/utils/functions.dart';
import 'package:corrispay/features/bases/widgets/rounded_back_button.dart';
import 'package:corrispay/features/mobiles-transactions/dto/withdrawal-mobile.dto.dart';
import 'package:corrispay/features/mobiles-transactions/providers/mobile-withdrawal.provider.dart';
import 'package:corrispay/features/transactions/models/country_operator_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../../../app/routes/routes_names.dart';
import '../../../l10n/app_localizations.dart';
import '../../bases/widgets/default_button.dart';
import '../models/model_recipient.dart';
import '../widgets/country_selector_field.dart';
import '../widgets/number_selector_field.dart';
import '../widgets/operator_selector_field.dart';
import 'number_pick_view.dart';

class EnterWithdrawalPhoneNumber extends ConsumerStatefulWidget {
  const EnterWithdrawalPhoneNumber({super.key, required this.data});
  final (double, List<CountryOperatorModel>) data;

  @override
  ConsumerState<EnterWithdrawalPhoneNumber> createState() =>
      _EnterWithdrawalPhoneNumberState();
}

class _EnterWithdrawalPhoneNumberState
    extends ConsumerState<EnterWithdrawalPhoneNumber> {
  // Rien n'est présélectionné — l'utilisateur doit choisir explicitement
  // pays, puis réseau, puis destinataire, dans cet ordre.
  CountryOperatorModel? selectedCountry;
  Operator? selectedMobileMoney;
  MobileMoneyRecipient? selectedRecipient;

  bool get _isFormValid =>
      selectedCountry != null &&
          selectedMobileMoney != null &&
          selectedRecipient != null;

  Future<void> _pickCountry() async {
    final result = await showCountryPicker(
      context: context,
      countries: widget.data.$2,
      selected: selectedCountry,
    );
    if (result != null) {
      setState(() {
        selectedCountry = result;
        // Changer de pays invalide le réseau et le destinataire
        // précédemment choisis — on force une nouvelle sélection
        // cohérente plutôt que de garder un état incohérent.
        selectedMobileMoney = null;
        selectedRecipient = null;
      });
    }
  }

  Future<void> _pickOperator() async {
    if (selectedCountry == null) return;

    final result = await showOperatorPicker(
      context: context,
      operators: selectedCountry!.operators,
      selected: selectedMobileMoney,
      countryLabel: selectedCountry!.label,
    );
    if (result != null) {
      setState(() => selectedMobileMoney = result);
    }
  }

  /// Ouvre l'écran de sélection du numéro, filtré sur le pays choisi —
  /// nécessite qu'un pays soit déjà sélectionné (sinon aucun indicatif
  /// à filtrer, on ne devrait de toute façon jamais arriver ici puisque
  /// le champ est désactivé tant que selectedCountry est null).
  Future<void> _pickRecipient() async {
    if (selectedCountry == null) return;

    final result = await Navigator.push<MobileMoneyRecipient>(
      context,
      MaterialPageRoute(
        builder: (_) => NumberPickerView(
          dialCode: selectedCountry!.dialCode,
          countryLabel: selectedCountry!.label,
          phoneLength: selectedCountry!.phoneLength,
          countryCode: selectedCountry!.countryCode,
        ),
      ),
    );
    if (result != null) {
      setState(() => selectedRecipient = result);
    }
  }

  void submitForm() async {
    if (!_isFormValid) return;

    showLoading();
    final response = await ref.read(
      previewMobileWithdrawalProvider(
        WithdrawalMobileDto(
          amount: widget.data.$1,
          operator: selectedMobileMoney!.key,
          country: selectedCountry!.key,
          phoneNumber: selectedRecipient!.phoneNumber,
        ),
      ).future,
    );
    hideLoading();

    if (response != null && response.status && response.data != null) {
      if (!mounted) return;
      Navigator.pushNamed(
        context,
        RoutesNames.withdrawalSummaryView,
        arguments: response.data,
      );
    } else {
      showErrorMessage(response?.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Palette.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const RoundedBackButton(),
                const Gap(12),

                Text(
                  l10n.phoneNumber,
                  style: FontsStyles.bold.copyWith(fontSize: 22),
                ),

                const Gap(12),

                // ── Montant ───────────────────────────
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Palette.petrolBlue.withOpacity(0.07),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.account_balance_wallet_rounded,
                        size: 14,
                        color: Palette.petrolBlue,
                      ),
                      const Gap(6),
                      Text(
                        "${l10n.amount} : ${widget.data.$1.toStringAsFixed(0)}",
                        style: FontsStyles.medium.copyWith(
                          fontSize: 12.5,
                          color: Palette.petrolBlue,
                        ),
                      ),
                    ],
                  ),
                ),

                const Gap(24),

                Text(
                  l10n.country.toUpperCase(),
                  style: FontsStyles.bold.copyWith(
                    fontSize: 11,
                    color: const Color(0xFF9CA3AF),
                    letterSpacing: 0.8,
                  ),
                ),
                const Gap(8),

                CountrySelectorField(
                  selected: selectedCountry,
                  onTap: _pickCountry,
                ),

                const Gap(20),

                Text(
                  'RESEAU MOBILE MONEY',
                  style: FontsStyles.bold.copyWith(
                    fontSize: 11,
                    color: const Color(0xFF9CA3AF),
                    letterSpacing: 0.8,
                  ),
                ),
                const Gap(8),

                // Désactivé tant qu'aucun pays n'est choisi — pas de
                // réseau disponible sans savoir dans quel pays chercher.
                IgnorePointer(
                  ignoring: selectedCountry == null,
                  child: Opacity(
                    opacity: selectedCountry == null ? 0.5 : 1,
                    child: OperatorSelectorField(
                      selected: selectedMobileMoney,
                      onTap: _pickOperator,
                    ),
                  ),
                ),

                const Gap(20),

                Text(
                  'NUMERO DE RECEPTION',
                  style: FontsStyles.bold.copyWith(
                    fontSize: 11,
                    color: const Color(0xFF9CA3AF),
                    letterSpacing: 0.8,
                  ),
                ),
                const Gap(8),

                IgnorePointer(
                  ignoring: selectedMobileMoney == null,
                  child: Opacity(
                    opacity: selectedMobileMoney == null ? 0.5 : 1,
                    child: NumberSelectorField(
                      recipient: selectedRecipient,
                      onTap: _pickRecipient,
                    ),
                  ),
                ),

                const Gap(120),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        color: Palette.white,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        child: DefaultButton(
          isEnable: _isFormValid,
          bgColor: Palette.petrolBlue,
          onTap: submitForm,
          text: l10n.next,
          padding: 15,
          textStyle: FontsStyles.medium.copyWith(
            fontSize: 15,
            color: Palette.white,
          ),
        ),
      ),
    );
  }
}