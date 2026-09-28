import 'package:corrispay/features/mobiles-transactions/dto/confirm-withdrawal-mobile.dto.dart';
import 'package:corrispay/features/mobiles-transactions/dto/withdrawal-mobile.dto.dart';
import 'package:corrispay/features/mobiles-transactions/responses/mobile_withdrawal_preview_response.dart';
import 'package:corrispay/features/mobiles-transactions/responses/withdrawal_response.dart';
import 'package:corrispay/features/mobiles-transactions/services/mobile-withdrawal.service.dart';
import 'package:riverpod/riverpod.dart';
import '../../../core/network/network_module.dart';

class MobileWithdrawalRepository {
  final MobileWithdrawalService mobileWithdrawalService;

  MobileWithdrawalRepository(this.mobileWithdrawalService);

  Future<MobileWithdrawalPreviewResponse?> previewMobileWithdrawal(
      WithdrawalMobileDto dto,
      ) async {
    try {
      print(dto.toJson());
      final response = await mobileWithdrawalService.previewWithdrawal(dto);
      print(response);
      return MobileWithdrawalPreviewResponse.fromJson(response);
    } catch (e) {
      print(' $e');
      return null;
    }
  }

  Future<WithdrawalResponse?> confirmWithdrawal(
      ConfirmWithdrawalMobileDto dto,
      ) async {
    try {
      print(dto.toJson());
      final response = await mobileWithdrawalService.confirmMobileWithdrawal(dto);
      print(response);
      return WithdrawalResponse.fromJson(response);
    } catch (e) {
      print(' $e');
      return null;
    }
  }
}

final mobileWithdrawalRepositoryProvider = Provider<MobileWithdrawalRepository>((
    ref,
    ) {
  return MobileWithdrawalRepository (
    chopperClient.getService<MobileWithdrawalService>(),
  );
});
