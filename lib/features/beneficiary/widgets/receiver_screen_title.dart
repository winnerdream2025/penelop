import 'package:corrispay/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';

class ReceiverScreenTitle extends StatelessWidget {
  const ReceiverScreenTitle({super.key, required this.tr});
  final AppLocalizations tr;

  @override
  Widget build(BuildContext context) {
    return Text(
      tr.chooseReceiver,
      style: FontsStyles.bold.copyWith(fontSize: 22, color: Palette.black),
    );
  }
}