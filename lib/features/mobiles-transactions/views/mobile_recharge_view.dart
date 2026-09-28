import 'package:corrispay/core/utils/functions.dart';
import 'package:corrispay/features/bases/widgets/default_button.dart';
import 'package:corrispay/features/bases/widgets/rounded_back_button.dart';
import 'package:corrispay/features/mobiles-transactions/providers/mobile-recharge.provider.dart';
import 'package:corrispay/features/transactions/models/country_operator_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../../../app/routes/routes_names.dart';
import '../../../core/local/userlocal_provider.dart';
import '../../../l10n/app_localizations.dart';
import '../dto/add_mobile_money_to_wallet.dto.dart';
import '../widgets/country_selector_field.dart';
import '../widgets/operator_selector_field.dart';

class EnterPhoneNumberToRechargeView extends ConsumerStatefulWidget {
  const EnterPhoneNumberToRechargeView({super.key, required this.data});

  final (double, List<CountryOperatorModel>) data;

  @override
  ConsumerState<EnterPhoneNumberToRechargeView> createState() =>
      _EnterPhoneNumberToRechargeViewState();
}

class _EnterPhoneNumberToRechargeViewState
    extends ConsumerState<EnterPhoneNumberToRechargeView> {
  late CountryOperatorModel selectedCountry;
  late Operator selectedMobileMoney;

  String? _localNumber;
  String? _prefillLocalNumber;

  @override
  void initState() {
    super.initState();

    final user = ref.read(userLocalProvider);

    // user.country est en MAJUSCULES, country.key est en minuscules —
    // on normalise les deux avant de comparer.
    selectedCountry = widget.data.$2.firstWhere(
          (c) => c.key.toUpperCase() == (user?.country.toUpperCase() ?? ''),
      orElse: () => widget.data.$2.first,
    );
    selectedMobileMoney = selectedCountry.operators.first;

    _tryPrefillOwnNumber(user?.phoneNumber);
  }

  /// Si le numéro de l'utilisateur (ex: "22898163825") correspond bien
  /// à l'indicatif du pays sélectionné ET a la bonne longueur locale,
  /// on le propose comme valeur par défaut. Sinon rien n'est pré-rempli.
  void _tryPrefillOwnNumber(String? fullPhoneNumber) {
    if (fullPhoneNumber == null) return;

    final normalizedDialCode = selectedCountry.dialCode.replaceAll('+', '');
    if (!fullPhoneNumber.startsWith(normalizedDialCode)) return;

    final localNumber = fullPhoneNumber.substring(normalizedDialCode.length);
    if (localNumber.length != selectedCountry.phoneLength) return;

    _localNumber = localNumber;
    _prefillLocalNumber = localNumber;
  }

  bool get _isOwnNumber =>
      _prefillLocalNumber != null && _localNumber == _prefillLocalNumber;

  bool get _isFormValid =>
      _localNumber != null &&
          _localNumber!.length == selectedCountry.phoneLength;

  Future<void> _pickCountry() async {
    final result = await showCountryPicker(
      context: context,
      countries: widget.data.$2,
      selected: selectedCountry,
    );
    if (result != null) {
      setState(() {
        selectedCountry = result;
        selectedMobileMoney = result.operators.first;
        _localNumber = null;
        _prefillLocalNumber = null;
        _tryPrefillOwnNumber(ref.read(userLocalProvider)?.phoneNumber);
      });
    }
  }

  Future<void> _pickOperator() async {
    final result = await showOperatorPicker(
      context: context,
      operators: selectedCountry.operators,
      selected: selectedMobileMoney,
      countryLabel: selectedCountry.label,
    );
    if (result != null) {
      setState(() => selectedMobileMoney = result);
    }
  }

  Future<void> _openNumberSheet() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _RechargeNumberSheet(
        dialCode: selectedCountry.dialCode,
        countryCode: selectedCountry.countryCode,
        phoneLength: selectedCountry.phoneLength,
        initialValue: _localNumber,
        isOwnNumberValue: _isOwnNumber ? _prefillLocalNumber : null,
      ),
    );
    if (result != null) {
      setState(() => _localNumber = result);
    }
  }

  void submitForm() async {
    if (!_isFormValid) return;

    showLoading();

    final response = await ref.read(
      previewMobileRechargeProvider(
        AddMobileMoneyToWalletDto(
          amount: widget.data.$1,
          phone: _localNumber!,
          country: selectedCountry.key,
          operator: selectedMobileMoney.key,
        ),
      ).future,
    );

    hideLoading();

    if (response != null && response.status && response.data != null) {
      if (!mounted) return;
      FocusScope.of(context).unfocus();
      Navigator.pushNamed(
        context,
        RoutesNames.confirmMobileMoneyView,
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
                  l10n.mobileRechargeTitle,
                  style: FontsStyles.bold.copyWith(fontSize: 22),
                ),

                const Gap(12),

                // ── Montant ───────────────────────────────
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
                        l10n.amountLabel(widget.data.$1.toStringAsFixed(0)),
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
                  l10n.operator.toUpperCase(),
                  style: FontsStyles.bold.copyWith(
                    fontSize: 11,
                    color: const Color(0xFF9CA3AF),
                    letterSpacing: 0.8,
                  ),
                ),
                const Gap(8),
                OperatorSelectorField(
                  selected: selectedMobileMoney,
                  onTap: _pickOperator,
                ),

                const Gap(20),

                Text(
                  l10n.phoneNumber.toUpperCase(),
                  style: FontsStyles.bold.copyWith(
                    fontSize: 11,
                    color: const Color(0xFF9CA3AF),
                    letterSpacing: 0.8,
                  ),
                ),
                const Gap(8),

                GestureDetector(
                  onTap: _openNumberSheet,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: _localNumber != null
                            ? Palette.petrolBlue
                            : const Color(0xFFEBEBEB),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: _localNumber != null
                                ? Palette.petrolBlue
                                : const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.phone_iphone_rounded,
                            size: 17,
                            color: _localNumber != null
                                ? Colors.white
                                : const Color(0xFF9CA3AF),
                          ),
                        ),
                        const Gap(12),
                        Expanded(
                          child: _localNumber != null
                              ? Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${selectedCountry.dialCode} $_localNumber',
                                style: FontsStyles.bold.copyWith(
                                  fontSize: 13.5,
                                  color: Palette.black,
                                ),
                              ),
                              if (_isOwnNumber) ...[
                                const Gap(2),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.check_circle_rounded,
                                      size: 11,
                                      color: Palette.teal,
                                    ),
                                    const Gap(4),
                                    Text(
                                      'Votre numero CaurisPay',
                                      style: FontsStyles.medium
                                          .copyWith(
                                        fontSize: 10.5,
                                        color: Palette.teal,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          )
                              : Text(
                            'Entrer le numero de paiement',
                            style: FontsStyles.regular.copyWith(
                              fontSize: 13.5,
                              color: const Color(0xFFB0B8C1),
                            ),
                          ),
                        ),
                        Icon(
                          _localNumber != null
                              ? Icons.edit_rounded
                              : Icons.chevron_right_rounded,
                          size: _localNumber != null ? 15 : 20,
                          color: _localNumber != null
                              ? Palette.petrolBlue
                              : const Color(0xFF9CA3AF),
                        ),
                      ],
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

/// Bottom sheet de saisie du numéro de paiement — s'ouvre au tap sur le
/// champ numéro. Pré-rempli avec le numéro CaurisPay de l'utilisateur
/// si [isOwnNumberValue] est fourni.
class _RechargeNumberSheet extends StatefulWidget {
  const _RechargeNumberSheet({
    required this.dialCode,
    required this.countryCode,
    required this.phoneLength,
    this.initialValue,
    this.isOwnNumberValue,
  });

  final String dialCode;
  final String countryCode;
  final int phoneLength;
  final String? initialValue;
  final String? isOwnNumberValue;

  @override
  State<_RechargeNumberSheet> createState() => _RechargeNumberSheetState();
}

class _RechargeNumberSheetState extends State<_RechargeNumberSheet> {
  late final TextEditingController _controller;

  bool get _isComplete => _controller.text.length == widget.phoneLength;
  bool get _isOwnNumber => _controller.text == widget.isOwnNumberValue;

  String get _flagEmoji {
    final code = widget.countryCode;
    if (code.length != 2) return '🌍';
    final base = 0x1F1E6;
    final chars = code.toUpperCase().codeUnits;
    return String.fromCharCodes(
      [base + (chars[0] - 65), base + (chars[1] - 65)],
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_isComplete) return;
    Navigator.pop(context, _controller.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Palette.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        20,
        18,
        20,
        MediaQuery.of(context).viewInsets.bottom +
            MediaQuery.of(context).padding.bottom +
            24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFEBEBEB),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 18),

          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Palette.petrolBlue.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.phone_iphone_rounded,
              size: 21,
              color: Palette.petrolBlue,
            ),
          ),
          const SizedBox(height: 14),

          Text(
            'Numero de paiement',
            style: FontsStyles.bold.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 4),
          Text(
            'Le numero mobile money utilise pour la recharge',
            style: FontsStyles.regular.copyWith(
              fontSize: 12,
              color: const Color(0xFF9CA3AF),
            ),
          ),
          const SizedBox(height: 20),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_flagEmoji, style: const TextStyle(fontSize: 15)),
                    const SizedBox(width: 6),
                    Text(
                      widget.dialCode,
                      style: FontsStyles.bold.copyWith(
                        fontSize: 13.5,
                        color: Palette.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Palette.petrolBlue, width: 1.5),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: TextField(
                      controller: _controller,
                      autofocus: widget.initialValue == null,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(widget.phoneLength),
                      ],
                      onChanged: (_) => setState(() {}),
                      style: FontsStyles.medium.copyWith(
                        fontSize: 13.5,
                        color: Palette.black,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        hintText: 'Ex: 90123456',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          if (_isOwnNumber)
            Row(
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  size: 12,
                  color: Palette.teal,
                ),
                const SizedBox(width: 5),
                Text(
                  'Votre numero CaurisPay',
                  style: FontsStyles.medium.copyWith(
                    fontSize: 11,
                    color: Palette.teal,
                  ),
                ),
              ],
            )
          else
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${_controller.text.length} / ${widget.phoneLength} chiffres',
                style: FontsStyles.regular.copyWith(
                  fontSize: 11,
                  color: _isComplete
                      ? const Color(0xFF0F6E56)
                      : const Color(0xFFDFB049),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

          const SizedBox(height: 20),

          GestureDetector(
            onTap: _isComplete ? _submit : null,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: _isComplete
                    ? Palette.petrolBlue
                    : const Color(0xFFEDEDED),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                'Valider ce numero',
                textAlign: TextAlign.center,
                style: FontsStyles.bold.copyWith(
                  fontSize: 14,
                  color:
                  _isComplete ? Colors.white : const Color(0xFF9CA3AF),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}