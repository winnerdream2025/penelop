import 'package:corrispay/features/bases/widgets/default_button.dart';
import 'package:corrispay/features/bases/widgets/rounded_back_button.dart';
import 'package:corrispay/features/merchant/dto/create-merchant-account.dto.dart';
import 'package:corrispay/features/merchant/providers/merchant.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../../../core/utils/functions.dart';
import '../../bases/widgets/default_field.dart';

class MerchantRegistrationView extends ConsumerStatefulWidget {
  const MerchantRegistrationView({super.key});

  @override
  ConsumerState<MerchantRegistrationView> createState() =>
      _MerchantRegistrationViewState();
}

class _MerchantRegistrationViewState
    extends ConsumerState<MerchantRegistrationView> {
  final _formKey = GlobalKey<FormState>();
  final _designationController = TextEditingController();
  final _addressController = TextEditingController();


  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _designationController.addListener(_updateFormValidity);
    _addressController.addListener(_updateFormValidity);
  }

  void _updateFormValidity() {
    final isValid =
        _designationController.text.trim().isNotEmpty &&
        _addressController.text.trim().isNotEmpty;

    if (isValid != _isFormValid) {
      setState(() => _isFormValid = isValid);
    }
  }

  @override
  void dispose() {
    _designationController.removeListener(_updateFormValidity);
    _addressController.removeListener(_updateFormValidity);
    _designationController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    showLoading();
    final response = await ref.read(
      createMerchantAccountProvider(
        CreateMerchantAccountDto(
          address: _addressController.text,
          designation: _designationController.text,
        ),
      ).future,
    );
    hideLoading();
    if (!mounted) return;

    if (response != null && response.status) {
      showSuccessMessage(response.message);
      Navigator.pop(context);
    } else {
      showErrorMessage(response?.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(8),
              RoundedBackButton(),

              Gap(16),

              Text(
                'Devenir marchand',
                style: FontsStyles.bold.copyWith(
                  fontSize: 20,
                  color: Palette.black,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Recevez des paiements directement sur votre compte CaurisPay.',
                style: FontsStyles.regular.copyWith(
                  fontSize: 12.5,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
              ),

              Gap(24),

              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultField(
                        controller: _designationController,
                        label: 'NOM DU COMMERCE',
                        hintText: 'Boutique Awa',
                      ),

                      DefaultField(
                        controller: _addressController,
                        label: 'ADRESSE',
                        hintText: 'Lomé, Quartier Bè',
                      ),

                      const Spacer(),

                      DefaultButton(
                        padding: 16,
                        text: "Créer mon compte marchand",
                        onTap: _isFormValid ? _handleSubmit : null,
                        isEnable: _isFormValid,
                      ),
                      Gap(24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
