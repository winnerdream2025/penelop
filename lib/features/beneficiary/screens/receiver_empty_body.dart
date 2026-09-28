import 'package:corrispay/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../../bases/widgets/default_button.dart';

class ReceiverEmptyBody extends StatelessWidget {
  const ReceiverEmptyBody({
    super.key,
    required this.message,
    required this.tr,
    required this.onAddTap,
  });

  final String message;
  final AppLocalizations tr;
  final VoidCallback onAddTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: FontsStyles.bold.copyWith(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const Gap(8),
            Text(
              tr.add_beneficiary_text,
              style: FontsStyles.regular.copyWith(
                fontSize: 13,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(40),
            DefaultButton(
              hPadding: 14,
              bgColor: Palette.petrolBlue,
              text: tr.add_beneficiary,
              onTap: onAddTap,
            ),
          ],
        ),
      ),
    );
  }
}