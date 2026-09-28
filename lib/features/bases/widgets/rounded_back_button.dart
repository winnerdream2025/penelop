import 'package:flutter/material.dart';

class RoundedBackButton extends StatelessWidget {
  const RoundedBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return   Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: const EdgeInsets.only(top: 12),
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade100,
          ),
          child: const Icon(
            Icons.arrow_back,
            size: 18,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
