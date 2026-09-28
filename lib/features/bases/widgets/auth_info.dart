import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../app/design/fonts_styles.dart';
import '../../../../app/design/palette.dart';

class AuthInfo extends StatelessWidget {
  const AuthInfo(
      {super.key,
        required this.onTap,
        required this.option,
        required this.question});
  final String question;
  final String option;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
              text: question,
              style: FontsStyles.regular
                  .copyWith(fontSize: 14, color: Palette.black)),
          TextSpan(
              recognizer: TapGestureRecognizer()..onTap = onTap,
              text: option,
              style: FontsStyles.medium
                  .copyWith(fontSize: 14, color: Palette.orange)),
        ],
      ),
    );
  }
}