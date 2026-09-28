import 'package:chopper/chopper.dart';
import 'package:corrispay/features/account/dto/send-email-otp.dto.dart';
import '../dto/send-phone-otp.dto.dart';
import '../dto/verify_otp.dto.dart';
part 'otp_service.chopper.dart';

@ChopperApi(baseUrl: '/otp')
abstract class OtpService extends ChopperService {
  static OtpService create([ChopperClient? client]) => _$OtpService(client);



  @POST(path: '/send-phone')
  Future<Map<String, dynamic>> sendPhoneOtp(
      @Body() SendPhoneOtpDto sendPhoneOtpDto,
      @Query('lang') String lang,
      );

  @POST(path: '/verify')
  Future<Map<String, dynamic>> verifyOtp(
      @Body() VerifyOtpDto verifyOtpDto,
      @Query('lang') String lang,
      );
  @POST(path: '/request-reset')
  Future<Map<String, dynamic>> sendResetOtp(
      @Body() SendPhoneOtpDto sendPhoneOtpDto,
      );

  @POST(path: '/send-request-email')
  Future<Map<String, dynamic>> sendEmailResetOtp(
      @Body() SendEmailOtpDto dto,
      );

  @POST(path: '/send-email')
  Future<Map<String, dynamic>> sendEmailOtp(
      @Body() SendEmailOtpDto dto,
      );


}

