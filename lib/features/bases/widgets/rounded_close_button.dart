import 'package:corrispay/app/design/palette.dart';
import 'package:flutter/material.dart';

class RoundedCloseButton extends StatelessWidget {
  const RoundedCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: Color(0xFFF5F5F5),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.close_rounded,
            color: Palette.black,
            size: 18,
          ),
        ),
      ),
    );
  }
}
