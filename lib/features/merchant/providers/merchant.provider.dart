import 'package:corrispay/core/local/merchant_account.provider.dart';
import 'package:corrispay/features/merchant/dto/create-merchant-account.dto.dart';
import 'package:corrispay/features/merchant/repositories/merchant.repository.dart';
import 'package:corrispay/features/merchant/responses/merchant_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/local/userlocal_provider.dart';
import '../dto/transfer-between-accounts.dart';
import '../responses/account-response.dart';
import '../responses/intern-transfer.response.dart';

final createMerchantAccountProvider =
    FutureProvider.family<MerchantResponse?, CreateMerchantAccountDto>((
      ref,
      dto,
    ) async {
      final response = await ref
          .watch(merchantRepositoryProvider)
          .submitMerchantAccount(dto);
      if (response != null && response.status && response.data != null) {
        ref.read(userLocalProvider.notifier).addMerchantAccount();
        ref
            .read(merchantAccountLocalProvider.notifier)
            .saveMerchantAccount(response.data!);

        ref.invalidate(merchantAccountLocalProvider);

        ref.invalidate(userLocalProvider);
      }
      return response;
    });

final internTransferProvider =
    FutureProvider.family<InterTransferResponse?, TransferBetweenAccountsDto>((
      ref,
      dto,
    ) async {
      final response = await ref
          .watch(merchantRepositoryProvider)
          .interTransfer(dto);

      return response;
    });

final getAccountsProvider = FutureProvider.autoDispose<AccountResponse?>((ref) async {
  final response = await ref.watch(merchantRepositoryProvider).getAccounts();
  return response;
});
