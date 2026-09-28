import 'package:corrispay/app/routes/routes_names.dart';
import 'package:corrispay/core/utils/custom_inputs_formatters.dart';
import 'package:corrispay/features/auth/dto/register.dto.dart';
import 'package:corrispay/features/bases/widgets/rounded_back_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/design/assets/assets_icons.dart';
import '../../../../app/design/fonts_styles.dart';
import '../../../../app/design/palette.dart';
import '../../../../l10n/app_localizations.dart';
import '../../bases/widgets/default_button.dart';
import '../../bases/widgets/default_field.dart';

class PersonalInfoView extends ConsumerStatefulWidget {
  const PersonalInfoView({super.key, required this.registerDto});
  final RegisterDto registerDto;

  @override
  ConsumerState<PersonalInfoView> createState() => _PersonalInfoViewState();
}

class _PersonalInfoViewState extends ConsumerState<PersonalInfoView> {
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    super.dispose();
  }

  bool _isFormValid() {
    return firstnameController.text.length >= 2 &&
        lastnameController.text.length >= 2;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Palette.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

            RoundedBackButton(),

              const Gap(8),


              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: Palette.petrolBlue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_outline_rounded,
                  color: Palette.petrolBlue,
                  size: 26,
                ),
              ),

              const Gap(8),


              Text(
                loc.personalInfoTitle,
                style: FontsStyles.bold.copyWith(fontSize: 24),
              ),

              const Gap(4),


              Text(
                loc.personalInfoDescription,
                textAlign: TextAlign.center,
                style: FontsStyles.regular.copyWith(
                  fontSize: 13,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),

              const Gap(16),


              DefaultField(
                controller: lastnameController,
                label: loc.lastName,
                prefixIconUrl: AssetsIcons.phone,
                hintText: loc.lastName,
                inputsFormatters: [UpperCaseTextFormatter()],
                onChanged: (v) => setState(() {}),
              ),




              DefaultField(
                controller: firstnameController,
                label: loc.firstName,
                inputsFormatters: [CapitalizeFirstCharFormatter()],
                prefixIconUrl: AssetsIcons.phone,
                hintText: loc.firstName,
                onChanged: (v) => setState(() {}),
              ),





            ],
          ),
        ),
      ),
      bottomSheet:Container(
        color: Palette.white,
        padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
          bottom: 24
        ),
        child: DefaultButton(
          isEnable: _isFormValid(),
          onTap: () {
            if (_isFormValid()) {
              FocusScope.of(context).unfocus();
              Navigator.pushNamed(
                context,
                RoutesNames.security,
                arguments: widget.registerDto.copyWith(
                  lastName: lastnameController.text,
                  firstName: firstnameController.text,
                ),
              );
            }
          },
          bgColor: Palette.petrolBlue,
          text: loc.next,
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