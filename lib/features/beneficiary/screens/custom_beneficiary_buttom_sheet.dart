import 'package:corrispay/core/utils/functions.dart';
import 'package:corrispay/features/beneficiary/providers/beneficiary.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../../../core/local/userlocal_provider.dart' show userLocalProvider;
import '../../../l10n/app_localizations.dart';
import '../../account/widgets/info_row.dart';
import '../../bases/widgets/default_button.dart';
import '../models/beneficiary.model.dart';

class CustomBeneficiaryBottomSheet extends ConsumerStatefulWidget {
  const CustomBeneficiaryBottomSheet({super.key, required this.beneficiary});

  final Beneficiary beneficiary;

  @override
  ConsumerState<CustomBeneficiaryBottomSheet> createState() =>
      _CustomBeneficiaryBottomSheetState();
}

class _CustomBeneficiaryBottomSheetState
    extends ConsumerState<CustomBeneficiaryBottomSheet> {
  bool _isSubmitting = false;

  Future<void> _confirmAdd() async {
    setState(() => _isSubmitting = true);
    showLoading();

    final _ = ref.read(userLocalProvider);

    final response = await ref.read(
      addBeneficiaryProvider(widget.beneficiary.phoneNumber).future,
    );

    hideLoading();
    if (!mounted) return;
    setState(() => _isSubmitting = false);

    if (response != null && response.status == true) {
      Navigator.of(context).pop(widget.beneficiary);
      Navigator.of(context).pop(widget.beneficiary);
      Navigator.of(context).pop(widget.beneficiary);
    } else {
      showErrorMessage(response?.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return Container(
      decoration: const BoxDecoration(
        color: Palette.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        24,
        16,
        24,
        MediaQuery.of(context).padding.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFEBEBEB),
              borderRadius: BorderRadius.circular(4),
            ),
          ),

          const Gap(18),

          // Avatar avec initiales
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: Palette.petrolBlue,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${widget.beneficiary.firstName[0]}${widget.beneficiary.lastName[0]}'
                    .toUpperCase(),
                style: FontsStyles.bold.copyWith(
                  fontSize: 18,
                  color: Palette.white,
                ),
              ),
            ),
          ),

          const Gap(12),

          Text(
            '${widget.beneficiary.firstName} ${widget.beneficiary.lastName}',
            style: FontsStyles.bold.copyWith(fontSize: 16),
          ),

          const Gap(2),

          Text(
            widget.beneficiary.phoneNumber,
            style: FontsStyles.regular.copyWith(
              fontSize: 11.5,
              color: Colors.grey.shade400,
            ),
          ),

          const Gap(20),

          // Infos bénéficiaire
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F8F9),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                InfoRow(
                  label: tr.completed_name,
                  value:
                  '${widget.beneficiary.firstName} ${widget.beneficiary.lastName}',
                ),
                const Divider(height: 1, color: Color(0xFFE5E5E5)),
                InfoRow(
                  label: tr.account,
                  value: widget.beneficiary.phoneNumber,
                ),
              ],
            ),
          ),

          const Gap(20),


          DefaultButton(
            hPadding: 14,
            bgColor: Palette.petrolBlue,
            text: tr.add_this_contact,
            isEnable: !_isSubmitting,
            onTap: _confirmAdd,
          ),

          const Gap(10),


          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFE04040).withOpacity(0.06),
                border: Border.all(
                  color: const Color(0xFFE04040).withOpacity(0.25),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Text(
                tr.not_correct,
                textAlign: TextAlign.center,
                style: FontsStyles.bold.copyWith(
                  fontSize: 13,
                  color: const Color(0xFFE04040),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

