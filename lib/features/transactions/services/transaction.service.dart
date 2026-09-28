import 'package:corrispay/features/mobiles-transactions/dto/add_mobile_money_to_wallet.dto.dart';
import 'package:corrispay/features/beneficiary/dto/check_qr_code_info_dto.dart';
import 'package:corrispay/features/transactions/dto/confirm_intern_transaction.dto.dart';
import 'package:corrispay/features/transactions/dto/create_intern_transaction.dto.dart';
import "dart:async";
import 'package:chopper/chopper.dart';
import 'package:corrispay/features/transactions/dto/withdraw_dto.dart';
part 'transaction.service.chopper.dart';

@ChopperApi(baseUrl: '/transactions')
abstract class TransactionService extends ChopperService {
  static TransactionService create([ChopperClient? client]) =>
      _$TransactionService(client);

  @POST(path: '/intern')
  Future<Map<String, dynamic>> createInternTransaction(
    @Body() CreateInternTransactionDto createInternTransaction,
  );

  @POST(path: '/confirm-intern')
  Future<Map<String, dynamic>> confirmInternTransaction(
    @Body() ConfirmInternTransactionDto confirmInternTransaction,
  );

  @POST(path: '/mobile-money')
  Future<Map<String, dynamic>> addMobileMoneyToWallet(
    @Body() AddMobileMoneyToWalletDto addMobileMoneyToWallet,
  );

  @POST(path: '/withdraw')
  Future<Map<String, dynamic>> withdrawMoneyToMobileMoney(
    @Body() WithdrawDto dto,
  );

  @POST(path: '/withdraw/confirm')
  Future<Map<String, dynamic>> confirmWithdrawMoneyToMobileMoney(
    @Body() ConfirmInternTransactionDto dto,
  );

  @GET(path: '/country-list')
  Future<List<dynamic>> getCountriesWithMobileMoney(
    @Query('operationType') String operationType,
  );
  

  @GET(path: '/me')
  Future<Map<String, dynamic>> getTransactions(
      @Query('page') int page,
      @Query('limit') int limit,
      );

  @POST(path: '/check-qrcode-info')
  Future<Map<String, dynamic>> chekQrCodeInfo(@Body() CheckQrCodeInfoDto dto);
}
