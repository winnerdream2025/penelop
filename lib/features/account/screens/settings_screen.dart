import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../app/design/palette.dart';

class SubSettingScreen extends StatelessWidget {
  const SubSettingScreen({
    super.key,
    required this.title,
    required this.children,
  });
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: FontsStyles.bold.copyWith(
            fontSize: 20,
            color: Palette.black,
          ),),
          Gap(8),
          ...children,
        ],
      ),
    );
  }
}