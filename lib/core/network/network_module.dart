import 'package:chopper/chopper.dart';
import 'package:corrispay/core/local/userlocal_provider.dart';
import 'package:corrispay/features/bases/services/app_info.service.dart';
import 'package:corrispay/features/auth/services/otp_service.dart';
import 'package:corrispay/features/beneficiary/services/beneficiary.service.dart';
import 'package:corrispay/features/merchant/services/merchant.service.dart';
import 'package:corrispay/features/mobiles-transactions/services/mobile-recharge.service.dart';
import 'package:corrispay/features/mobiles-transactions/services/mobile-withdrawal.service.dart';
import 'package:corrispay/features/notifications/services/notifications.service.dart';
import 'package:corrispay/features/requests/services/user-request.service.dart';
import 'package:corrispay/features/transactions/services/country.service.dart';
import 'package:corrispay/features/transactions/services/transaction.service.dart';
import '../../app/utils/app_urls.dart';
import '../../features/auth/services/user_auth.service.dart';
import 'dart:async';
import '../../features/bases/providers/language_provider.dart';

class HeaderInterceptor implements Interceptor {
  final String language;

  HeaderInterceptor(this.language);

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
    Chain<BodyType> chain,
  ) async {
    final lang = LanguageUtils.getLanguageCode();
    final token = UserUtils.getToken();

    Request request = applyHeader(chain.request, 'x-lang', lang);

    request = applyHeader(request, 'Authorization', 'Bearer $token');

    return chain.proceed(request);
  }
}

final chopperClient = ChopperClient(
  baseUrl: Uri.parse(AppUrls.serverUrl),
  services: [
    UserAuthService.create(),
    OtpService.create(),
    TransactionService.create(),
    CountryService.create(),
    AppConfigService.create(),
    MobileRechargeService.create(),
    MobileWithdrawalService.create(),
    NotificationsService.create(),
    BeneficiaryService.create(),
    UserRequestService.create(),
    MerchantService.create()
  ],
  converter: JsonConverter(),
  interceptors: [HeaderInterceptor('fr')],
);
