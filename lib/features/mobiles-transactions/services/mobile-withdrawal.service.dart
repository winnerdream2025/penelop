import "dart:async";
import 'package:chopper/chopper.dart';
import 'package:corrispay/features/mobiles-transactions/dto/confirm-withdrawal-mobile.dto.dart';
import 'package:corrispay/features/mobiles-transactions/dto/withdrawal-mobile.dto.dart';
part 'mobile-withdrawal.service.chopper.dart';

@ChopperApi(baseUrl: '/withdrawal')
abstract class MobileWithdrawalService extends ChopperService {
  static MobileWithdrawalService create([ChopperClient? client]) =>
      _$MobileWithdrawalService(client);

  @POST(path: '/preview-mobile-money')
  Future<Map<String, dynamic>> previewWithdrawal(
    @Body() WithdrawalMobileDto dto,
  );

  @POST(path: '/confirm')
  Future<Map<String, dynamic>> confirmMobileWithdrawal(
    @Body() ConfirmWithdrawalMobileDto dto,
  );
}
