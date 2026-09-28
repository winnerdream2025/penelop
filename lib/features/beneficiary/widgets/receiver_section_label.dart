import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:flutter/material.dart';

class ReceiverSectionLabel extends StatelessWidget {
  const ReceiverSectionLabel({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: FontsStyles.bold.copyWith(
        fontSize: 10,
        color: Colors.grey.shade400,
        letterSpacing: 1.0,
      ),
    );
  }
}