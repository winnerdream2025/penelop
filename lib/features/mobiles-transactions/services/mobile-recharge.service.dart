import 'package:corrispay/features/mobiles-transactions/dto/add_mobile_money_to_wallet.dto.dart';
import "dart:async";
import 'package:chopper/chopper.dart';
part 'mobile-recharge.service.chopper.dart';

@ChopperApi(baseUrl: '/mobile-recharge')
abstract class MobileRechargeService extends ChopperService {
  static MobileRechargeService create([ChopperClient? client]) =>
      _$MobileRechargeService(client);


  @POST(path: '/preview')
  Future<Map<String, dynamic>> previewMobileRecharge(
      @Body() AddMobileMoneyToWalletDto addMobileMoneyToWallet,
      );

  @POST(path: '/confirm')
  Future<Map<String, dynamic>> confirmMobileRecharge(
      @Body() AddMobileMoneyToWalletDto dto
      );

}
