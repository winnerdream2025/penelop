import 'package:corrispay/features/merchant/dto/create-merchant-account.dto.dart';
import 'package:corrispay/features/merchant/dto/transfer-between-accounts.dart';
import 'package:corrispay/features/merchant/responses/account-response.dart';
import 'package:corrispay/features/merchant/responses/merchant_response.dart';
import 'package:corrispay/features/merchant/services/merchant.service.dart';
import '../../../core/network/network_module.dart';
import 'dart:async';
import 'package:riverpod/riverpod.dart';

import '../responses/intern-transfer.response.dart';

class MerchantRepository {
  final MerchantService merchantService;

  MerchantRepository(this.merchantService);

  Future<MerchantResponse?> submitMerchantAccount(
    CreateMerchantAccountDto dto,
  ) async {
    try {
      final response = await merchantService.submitMerchantAccount(dto);
      return MerchantResponse.fromJson(response);
    } catch (e) {
      print("err $e");
      return null;
    }
  }

  Future<AccountResponse?> getAccounts() async {
    try {
      final response = await merchantService.getAccounts();
      return AccountResponse.fromJson(response);
    } catch (e) {
      print("err $e");
      return null;
    }
  }

  Future<InterTransferResponse?> interTransfer(TransferBetweenAccountsDto dto) async {
    try {
      final response = await merchantService.interTransfer(dto);
      print(response);
      return InterTransferResponse.fromJson(response);
    } catch (e) {
      print("err $e");
      return null;
    }
  }
}

final merchantRepositoryProvider = Provider<MerchantRepository>((ref) {
  final merchantService = chopperClient.getService<MerchantService>();
  return MerchantRepository(merchantService);
});
