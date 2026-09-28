import 'package:flutter/material.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../models/model_recipient.dart';


class NumberSelectorField extends StatelessWidget {
  const NumberSelectorField({
    super.key,
    required this.recipient,
    required this.onTap,
  });

  final MobileMoneyRecipient? recipient;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasRecipient = recipient != null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: hasRecipient ? Palette.petrolBlue : const Color(0xFFEBEBEB),
            width: 1.5,
          ),
        ),
        child: hasRecipient
            ? Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Palette.petrolBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  recipient!.initials,
                  style: FontsStyles.bold.copyWith(
                    fontSize: 12.5,
                    color: Palette.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipient!.displayName,
                    style: FontsStyles.bold.copyWith(
                      fontSize: 13.5,
                      color: Palette.black,
                    ),
                  ),
                  if (recipient!.name != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      recipient!.phoneNumber,
                      style: FontsStyles.regular.copyWith(
                        fontSize: 11.5,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Palette.petrolBlue.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.edit_rounded,
                size: 11,
                color: Palette.petrolBlue,
              ),
            ),
          ],
        )
            : Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.contact_page_outlined,
                size: 18,
                color: Color(0xFF9CA3AF),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Choisir un contact ou saisir un numero',
                style: FontsStyles.regular.copyWith(
                  fontSize: 13,
                  color: const Color(0xFFB0B8C1),
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: Color(0xFF9CA3AF),
            ),
          ],
        ),
      ),
    );
  }
}