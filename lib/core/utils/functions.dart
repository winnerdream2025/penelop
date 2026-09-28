import 'dart:io';
import 'package:corrispay/core/utils/toast.dart';
import 'package:corrispay/core/utils/types.dart';
import 'package:flutter/material.dart';
import '../../app/design/palette.dart';
import '../../features/bases/widgets/dialog_loading.dart';
import '../../l10n/app_localizations.dart';
import '../../main.dart';

showLoading() {
  showDialog(
    barrierDismissible: false,
    context: navigatorKey.currentState!.context,
    builder: (context) {
      return const DialogLoading();
    },
  );
}

hideLoading() {
  Navigator.pop(navigatorKey.currentState!.context);
}

void showSuccessMessage(String message) {
  showTopToast(
    message: message,
    backgroundColor: Palette.petrolBlue,
    icon: Icons.check_circle_outline_rounded,
  );
}

void showErrorMessage(String? message) {
  final resolvedMessage =
      message ??
      AppLocalizations.of(navigatorKey.currentState!.context)!.common_error;

  showTopToast(
    message: resolvedMessage,
    backgroundColor: const Color(0xFFE04040),
    icon: Icons.error_outline_rounded,
  );
}

QrCodeResponse parseInput(String input) {
  List<String> parts = input.split(',');
  if (parts.length != 2) {
    throw FormatException('Input must be in the format "price,userId"');
  }

  return QrCodeResponse(amount: parts[0], customerId: parts[1]);
}

getAccountBalance(double rate, double balance) {
  return (balance * rate).toStringAsFixed(2);
}

String getPlatform() {
  if (Platform.isAndroid) return "android";
  if (Platform.isIOS) return "ios";
  return "unknown";
}

int compareVersions(String v1, String v2) {
  final parts1 = v1.split('.').map(int.parse).toList();
  final parts2 = v2.split('.').map(int.parse).toList();

  final maxLength = parts1.length > parts2.length
      ? parts1.length
      : parts2.length;

  for (int i = 0; i < maxLength; i++) {
    final num1 = i < parts1.length ? parts1[i] : 0;
    final num2 = i < parts2.length ? parts2[i] : 0;

    if (num1 > num2) return 1;
    if (num1 < num2) return -1;
  }

  return 0;
}

extension VersionCompare on String {
  int compareToVersion(String other) {
    return compareVersions(this, other);
  }
}
