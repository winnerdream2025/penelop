import 'package:corrispay/features/bases/widgets/rounded_close_button.dart';
import 'package:corrispay/features/beneficiary/providers/beneficiary.provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../../../core/local/userlocal_provider.dart';
import '../../../core/utils/functions.dart';
import '../../../l10n/app_localizations.dart';
import '../../bases/providers/country_provider.dart';
import '../../bases/widgets/default_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../bases/widgets/default_country_field.dart';
import '../../bases/widgets/default_phone_field.dart';
import '../../transactions/models/country_operator_model.dart';
import '../screens/custom_beneficiary_buttom_sheet.dart';

class AddNewReceiverView extends ConsumerStatefulWidget {
  const AddNewReceiverView({super.key});

  @override
  ConsumerState<AddNewReceiverView> createState() => _AddNewReceiverViewState();
}

class _AddNewReceiverViewState extends ConsumerState<AddNewReceiverView> {
  final TextEditingController phoneController = TextEditingController();
  bool isPhoneNumberValid = false;
  CountryOperatorModel? selectedCountry;

  @override
  void initState() {
    super.initState();

    final countryCode = ref.read(countryProvider);

    if (countryCode != null) {
      selectedCountry = countries.firstWhere(
        (element) => element.countryCode == countryCode,
        orElse: () => countries.first,
      );
    } else {
      selectedCountry = countries.first;
    }

    phoneController.addListener(() {
      setState(() {
        isPhoneNumberValid =
            phoneController.text.length == selectedCountry?.phoneLength;
      });
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  String get _fullTypedNumber =>
      '${selectedCountry?.dialCode ?? ''}${phoneController.text}'.replaceAll(
        '+',
        '',
      );

  bool get _isSelfNumber {
    final user = ref.watch(userLocalProvider);
    if (user == null || phoneController.text.isEmpty) return false;
    final ownNumber = user.phoneNumber.replaceAll('+', '');
    return _fullTypedNumber == ownNumber;
  }

  bool get _canSubmit => isPhoneNumberValid && !_isSelfNumber;

  Future<void> submitForm() async {
    if (_isSelfNumber) return;

    showLoading();

    final userResponse = await ref.read(
      checkBeneficiaryByPhoneNumberProvider(
        selectedCountry!.dialCode + phoneController.text,
      ).future,
    );

    hideLoading();

    if (userResponse != null &&
        userResponse.status == true &&
        userResponse.data != null) {
      if (!mounted) return;
      showModalBottomSheet(
        isDismissible: false,
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return CustomBeneficiaryBottomSheet(beneficiary: userResponse.data!);
        },
      );
    } else {
      showErrorMessage(userResponse?.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    final isSelfNumber = _isSelfNumber;

    return Scaffold(
      backgroundColor: Palette.white,
      appBar: AppBar(
        backgroundColor: Palette.white,
        elevation: 0,
        leading: RoundedCloseButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(8),

            Text(
              tr.newReceiver,
              style: FontsStyles.bold.copyWith(fontSize: 24),
            ),

            const Gap(6),

            Text(
              tr.enter_receiver_phone,
              style: FontsStyles.regular.copyWith(
                fontSize: 13,
                color: Colors.black54,
                height: 1.5,
              ),
            ),

            const Gap(16),

            DefaultPhoneField(
              controller: phoneController,
              selectedCountry: selectedCountry!,
              onChanged: (v) => setState(() {}),
              updateSelectedCountry: (val) {
                setState(() {
                  selectedCountry = val;
                });
                phoneController.clear();
              },
            ),

            if (isSelfNumber) ...[
              const Gap(10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF1E6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.error_outline_rounded,
                      size: 15,
                      color: Palette.orange,
                    ),
                    const Gap(8),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: FontsStyles.regular.copyWith(
                            fontSize: 11,
                            color: const Color(0xFF854F0B),
                            height: 1.5,
                          ),
                          children: [
                            TextSpan(text: tr.cannot_add_self_beneficiary),
                            const TextSpan(text: ' '),
                            TextSpan(
                              text: tr.use_withdrawal_instead,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const Spacer(),

            DefaultButton(
              isEnable: _canSubmit,
              onTap: submitForm,
              bgColor: Palette.petrolBlue,
              text: tr.confirm,
              padding: 16,
              textStyle: FontsStyles.regular.copyWith(
                fontSize: 16,
                color: Palette.white,
              ),
            ),

            const Gap(32),
          ],
        ),
      ),
    );
  }
}
