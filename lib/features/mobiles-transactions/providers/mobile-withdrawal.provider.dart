import 'package:corrispay/features/mobiles-transactions/dto/confirm-withdrawal-mobile.dto.dart';
import 'package:corrispay/features/mobiles-transactions/dto/withdrawal-mobile.dto.dart';
import 'package:corrispay/features/mobiles-transactions/responses/mobile_withdrawal_preview_response.dart';
import 'package:corrispay/features/mobiles-transactions/responses/withdrawal_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/mobile-withdrawal.repository.dart';

final previewMobileWithdrawalProvider =
FutureProvider.family<
    MobileWithdrawalPreviewResponse?,
    WithdrawalMobileDto
>((ref, dto) async {
  return await ref
      .watch(mobileWithdrawalRepositoryProvider)
      .previewMobileWithdrawal(dto);
});



final confirmMobileWithdrawalProvider =
FutureProvider.family<
    WithdrawalResponse?,
    ConfirmWithdrawalMobileDto
>((ref, dto) async {
  return await ref
      .watch(mobileWithdrawalRepositoryProvider)
      .confirmWithdrawal(dto);
});
