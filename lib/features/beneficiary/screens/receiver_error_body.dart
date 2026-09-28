import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../../bases/widgets/default_button.dart';

class ReceiverErrorBody extends StatelessWidget {
  const ReceiverErrorBody({
    super.key,
    required this.message,
    required this.btnText,
    required this.onRetry,
  });

  final String message;
  final String btnText;
  final VoidCallback onRetry;

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
              style: FontsStyles.regular.copyWith(
                color: Palette.black,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(24),
            DefaultButton(
              bgColor: Palette.petrolBlue,
              hPadding: 16,
              text: btnText,
              onTap: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}