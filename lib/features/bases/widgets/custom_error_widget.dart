import 'package:flutter/material.dart';
import '../../beneficiary/screens/receiver_error_body.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    required this.textError,
    required this.onTap,
    required this.btnText,
  });

  final String textError;
  final VoidCallback onTap;
  final String btnText;

  @override
  Widget build(BuildContext context) {
    return ReceiverErrorBody(
      message: textError,
      btnText: btnText,
      onRetry: onTap,
    );
  }
}