
import 'package:corrispay/features/bases/widgets/default_button.dart';
import 'package:flutter/material.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';

class WalletAction extends StatelessWidget {
  const WalletAction({
    super.key,
    required this.icon,
    required this.text,
    required this.bgColor,
    required this.iconColor,
    this.onTap,
  });
  final String text;
  final String icon;
  final Color bgColor;
  final Color iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultButton(
          onTap: onTap,
          bgColor: bgColor,
          padding: 12,
          raduis: 25,
          icon: icon,
          iconColor: iconColor,
        ),
        SizedBox(height: 8),
        Text(
          text,
          style: FontsStyles.regular.copyWith(
            color: Palette.black,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
