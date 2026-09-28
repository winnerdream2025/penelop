import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../app/design/palette.dart';

/// 🔥 DIALOG ERREUR
class SplashErrorConnexion extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onRetry;

  const SplashErrorConnexion({
    super.key,
    required this.title,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: IntrinsicHeight(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: FontsStyles.bold.copyWith(
                  color: Palette.petrolBlue,
                  fontSize: 24,
                ),
              ),
              const Gap(16),
              Text(
                message,
                style: FontsStyles.regular.copyWith(
                  fontSize: 14,
                  color: Palette.black,
                ),
              ),
              const Gap(24),
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    onRetry();
                  },
                  child: Text(
                    "Réessayer",
                    style: FontsStyles.bold.copyWith(
                      color: Palette.petrolBlue,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
