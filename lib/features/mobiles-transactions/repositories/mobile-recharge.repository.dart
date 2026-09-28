import 'package:corrispay/features/mobiles-transactions/dto/add_mobile_money_to_wallet.dto.dart';
import 'package:corrispay/features/mobiles-transactions/responses/mobile_deposit_response.dart';
import 'package:corrispay/features/mobiles-transactions/responses/mobile_recharge_preview_response.dart';
import 'package:corrispay/features/mobiles-transactions/services/mobile-recharge.service.dart';
import 'package:riverpod/riverpod.dart';
import '../../../core/network/network_module.dart';

class MobileRechargeRepository {
  final MobileRechargeService mobileRechargeService;

  MobileRechargeRepository(this.mobileRechargeService);

  Future<MobileRechargePreviewResponse?> previewMobileRecharge(
    AddMobileMoneyToWalletDto dto,
  ) async {
    try {
      print(dto.toJson());
      final response = await mobileRechargeService.previewMobileRecharge(dto);
      print(response);
      return MobileRechargePreviewResponse.fromJson(response);
    } catch (e) {
      print(' $e');
      return null;
    }
  }

  Future<MobileDepositResponse?> confirmMobileRecharge(
    AddMobileMoneyToWalletDto dto,
  ) async {
    try {
      print(dto.toJson());
      final response = await mobileRechargeService.confirmMobileRecharge(dto);
      print("response $response");
      return MobileDepositResponse.fromJson(response);
    } catch (e) {
      print(' $e');
      return null;
    }
  }
}

final mobileRechargeRepositoryProvider = Provider<MobileRechargeRepository>((
  ref,
) {
  return MobileRechargeRepository(
    chopperClient.getService<MobileRechargeService>(),
  );
});
