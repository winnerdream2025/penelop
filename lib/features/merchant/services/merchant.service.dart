import 'package:corrispay/features/merchant/dto/create-merchant-account.dto.dart';
import "dart:async";
import 'package:chopper/chopper.dart';
import 'package:corrispay/features/merchant/dto/transfer-between-accounts.dart';
part 'merchant.service.chopper.dart';

@ChopperApi(baseUrl: '/merchant-account')
abstract class MerchantService extends ChopperService {
  static MerchantService create([ChopperClient? client]) =>
      _$MerchantService(client);

  @POST(path: '')
  Future<Map<String, dynamic>> submitMerchantAccount(
    @Body() CreateMerchantAccountDto dto,
  );

  @POST(path: '/tranfer')
  Future<Map<String, dynamic>> interTransfer(
    @Body() TransferBetweenAccountsDto dto,
  );

  @GET(path: '/accounts')
  Future<Map<String, dynamic>> getAccounts();
}
