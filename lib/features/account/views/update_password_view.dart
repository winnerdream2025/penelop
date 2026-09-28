import 'package:corrispay/features/account/dto/update_password_dto.dart';
import 'package:corrispay/features/auth/providers/auth_provider.dart';
import 'package:corrispay/features/bases/widgets/rounded_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../app/design/assets/assets_icons.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../../../core/utils/functions.dart';
import '../../../l10n/app_localizations.dart';
import '../../bases/widgets/default_button.dart';
import '../../bases/widgets/default_field.dart';

class UpdatePasswordView extends ConsumerStatefulWidget {
  const UpdatePasswordView({super.key});

  @override
  ConsumerState<UpdatePasswordView> createState() =>
      _UpdatePasswordViewState();
}

class _UpdatePasswordViewState
    extends ConsumerState<UpdatePasswordView> {
  final _currentPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _isCurrentObscur = true;
  bool _isNewObscur = true;
  bool _isConfirmObscur = true;

  bool isEnabled = false;

  @override
  void initState() {
    super.initState();
    _currentPasswordController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
    _confirmController.addListener(_validateForm);
  }

  void _validateForm() {
    final valid =
        _currentPasswordController.text.trim().isNotEmpty &&
            _passwordController.text.trim().isNotEmpty &&
            _confirmController.text.trim().isNotEmpty &&
            _passwordController.text == _confirmController.text;

    if (valid != isEnabled) setState(() => isEnabled = valid);
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void submitForm() async {
    FocusScope.of(context).unfocus();
    showLoading();

    final response = await ref.read(
      updatePasswordProvider(
        UpdatePasswordDto(
          oldPassword: _currentPasswordController.text,
          newPassword: _passwordController.text,
        ),
      ).future,
    );

    hideLoading();

    if (response != null && response.status) {
      Navigator.pop(context);
      showSuccessMessage(response.message);
    } else {
      showErrorMessage(response?.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Palette.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior:
          ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RoundedBackButton(),
              const Gap(16),


              Text(
                tr.updatePasswordTitle,
                style: FontsStyles.bold.copyWith(fontSize: 20),
              ),

              Text(
                tr.updatePasswordSubtitle,
                style: FontsStyles.regular.copyWith(
                  fontSize: 12,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),

              const Gap(8),


              DefaultField(
                controller: _currentPasswordController,
                label: tr.currentPassword,
                prefixIconUrl: AssetsIcons.phone,
                hintText: tr.currentPassword,
                suffixIconUrl: _isCurrentObscur
                    ? AssetsIcons.eyeOff
                    : AssetsIcons.eyeOn,
                isObscur: _isCurrentObscur,
                onChanged: (v) => setState(() {}),
                changeObscur: () => setState(
                        () => _isCurrentObscur = !_isCurrentObscur),
              ),


              DefaultField(
                controller: _passwordController,
                label: tr.newPassword,
                prefixIconUrl: AssetsIcons.phone,
                hintText: tr.newPassword,
                suffixIconUrl: _isNewObscur
                    ? AssetsIcons.eyeOff
                    : AssetsIcons.eyeOn,
                isObscur: _isNewObscur,
                onChanged: (v) => setState(() {}),
                changeObscur: () =>
                    setState(() => _isNewObscur = !_isNewObscur),
              ),


              DefaultField(
                controller: _confirmController,
                label: tr.confirmPassword,
                hintText: tr.confirmPassword,
                prefixIconUrl: AssetsIcons.phone,
                suffixIconUrl: _isConfirmObscur
                    ? AssetsIcons.eyeOff
                    : AssetsIcons.eyeOn,
                isObscur: _isConfirmObscur,
                onChanged: (v) => setState(() {}),
                changeObscur: () => setState(
                        () => _isConfirmObscur = !_isConfirmObscur),
              ),
            ],
          ),
        ),
      ),

      bottomSheet: Container(
        color: Palette.white,
        padding:
        const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 24),
        child: DefaultButton(
          onTap: isEnabled ? submitForm : null,
          isEnable: isEnabled,
          bgColor: Palette.petrolBlue,
          text: tr.confirm,
          padding: 16,
          textStyle: FontsStyles.regular.copyWith(
            fontSize: 16,
            color: Palette.white,
          ),
        ),
      ),
    );
  }
}