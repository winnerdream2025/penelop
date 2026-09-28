import 'package:flutter/material.dart';

import '../../../app/design/fonts_styles.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: FontsStyles.bold.copyWith(
        fontSize: 10,
        color: Colors.grey.shade400,
        letterSpacing: 1.0,
      ),
    );
  }
}