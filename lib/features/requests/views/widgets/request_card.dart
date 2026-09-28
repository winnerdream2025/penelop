import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:corrispay/app/design/palette.dart';
import 'package:flutter/material.dart';
import '../../models/user-request.model.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({
    super.key,
    required this.request,
    required this.onReject,
    required this.onValidate,
    this.loading = false,
  });

  final UserRequest request;
  final VoidCallback onReject;
  final VoidCallback onValidate;
  final bool loading;

  bool get _isPayment => request.type == 'PAYMENT';

  IconData get _icon => _isPayment ? Icons.storefront_outlined : Icons.payments_outlined;

  int get _remainingMinutes {
    final diff = request.expiresAt.difference(DateTime.now()).inMinutes;
    return diff.clamp(0, 999);
  }

  bool get _isUrgent => _remainingMinutes <= 5;

  @override
  Widget build(BuildContext context) {
    final urgencyColor = _isUrgent ? const Color(0xFFA32D2D) : Colors.grey.shade600;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFEFEFEF)),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFEFEFEF)),
                ),
                child: Icon(_icon, size: 16, color: Palette.petrolBlue),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: FontsStyles.medium.copyWith(fontSize: 14, color: Palette.black),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      _isPayment ? 'Demande de paiement' : 'Demande de retrait',
                      style: FontsStyles.regular.copyWith(fontSize: 12, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _formatAmount(request.amount),
                    style: FontsStyles.medium.copyWith(fontSize: 15, color: Palette.black),
                  ),
                  Text(
                    request.currency,
                    style: FontsStyles.regular.copyWith(fontSize: 11, color: Colors.grey.shade400),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),
          const Divider(height: 1, color: Color(0xFFEFEFEF)),
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Expire dans',
                style: FontsStyles.regular.copyWith(fontSize: 12, color: Colors.grey.shade600),
              ),
              Text(
                '$_remainingMinutes min',
                style: FontsStyles.medium.copyWith(fontSize: 12, color: urgencyColor),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 36,
                  child: OutlinedButton(
                    onPressed: loading ? null : onReject,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFEFEFEF)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(
                      'Rejeter',
                      style: FontsStyles.medium.copyWith(fontSize: 13, color: Palette.black),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SizedBox(
                  height: 36,
                  child: ElevatedButton(
                    onPressed: loading ? null : onValidate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Palette.petrolBlue,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: loading
                        ? const SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                        : Text(
                      'Valider',
                      style: FontsStyles.medium.copyWith(fontSize: 13, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatAmount(String amount) {
    final value = double.tryParse(amount) ?? 0;
    return value.toInt().toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]} ',
    );
  }
}