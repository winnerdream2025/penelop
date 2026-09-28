import 'package:corrispay/features/mobiles-transactions/responses/mobile_deposit_response.dart';
import 'package:corrispay/features/mobiles-transactions/responses/mobile_recharge_preview_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../dto/add_mobile_money_to_wallet.dto.dart';
import '../repositories/mobile-recharge.repository.dart';

final previewMobileRechargeProvider =
    FutureProvider.family<
      MobileRechargePreviewResponse?,
      AddMobileMoneyToWalletDto
    >((ref, addMobileMoneyToWalletDto) async {
      return await ref
          .watch(mobileRechargeRepositoryProvider)
          .previewMobileRecharge(addMobileMoneyToWalletDto);
    });



final confirmMobileRechargeProvider =
FutureProvider.family<
    MobileDepositResponse?,
    AddMobileMoneyToWalletDto
>((ref, addMobileMoneyToWalletDto) async {
  return await ref
      .watch(mobileRechargeRepositoryProvider)
      .confirmMobileRecharge(addMobileMoneyToWalletDto);
});
