import 'package:corrispay/features/account/dto/add_email_to_account.dto.dart';
import 'package:corrispay/features/auth/dto/login_with_email.dto.dart';
import 'package:corrispay/features/auth/dto/login_with_pin_dto.dart';
import 'package:corrispay/features/auth/dto/reset-code-pin.dto.dart';
import 'package:corrispay/features/auth/dto/reset_password_dto.dart';
import 'package:corrispay/features/auth/dto/reset_password_email.dto.dart';
import 'package:corrispay/features/account/dto/set_pin.dto.dart';
import 'package:corrispay/features/account/dto/update_password_dto.dart';
import '../../beneficiary/dto/add_beneficiary.dto.dart';
import '../dto/create_update_pin.dto.dart';
import '../dto/login_phone.dto.dart';
import '../dto/register.dto.dart';
import "dart:async";
import 'package:chopper/chopper.dart';
part 'user_auth.service.chopper.dart';

@ChopperApi(baseUrl: '/auth')
abstract class UserAuthService extends ChopperService {
  static UserAuthService create([ChopperClient? client]) =>
      _$UserAuthService(client);

  @POST(path: '/register')
  Future<Map<String, dynamic>> register(
    @Body() RegisterDto registerDto,
  );

  @POST(path: '/login-with-phone')
  Future<Map<String, dynamic>> loginWithPhone(
    @Body() LoginPhoneDto loginPhoneDto,
  );

  @POST(path: '/create-pin')
  Future<Map<String, dynamic>> createOrUpdatePin(
    @Body() CreateUpdatePinDto createUpdatePinDto,
  );

  @POST(path: '/create-required-pin')
  Future<Map<String, dynamic>> createRequiredPin(
      @Body() CreateUpdatePinDto createUpdatePinDto,
      );

  @GET(path: '/beneficiaries')
  Future<Map<String, dynamic>> getBeneficiaries(
  );

  @POST(path: '/add-beneficiaries')
  Future<Map<String, dynamic>> addBeneficiary(
    @Body() AddBeneficiaryDto addBeneficiaryDto,
  );

  @GET(path: '/get/{phoneNumber}')
  Future<Map<String, dynamic>> getUserByPhoneNumber(
    @Path('phoneNumber') String phoneNumber,
  );


  @GET(path: '/account')
  Future<Map<String, dynamic>> getUserById(
    @Path('userId') String userId,
  );

  @PATCH(path: '/change-password')
  Future<Map<String, dynamic>> changePassword(@Body() UpdatePasswordDto dto);

  @PATCH(path: '/update-code')
  Future<Map<String, dynamic>> changeCodePin(@Body() SetPinDto dto);

  @POST(path: '/reset')
  Future<Map<String, dynamic>> resetPassword(@Body() ResetPasswordDto dto);

  @POST(path: '/reset-by-email')
  Future<Map<String, dynamic>> resetPasswordEmail(@Body() ResetPasswordEmailDto dto);

  @POST(path: '/login-with-pin')
  Future<Map<String, dynamic>> loginWithPin(@Body() LoginWithPinDto dto);

  @POST(path: '/add-email')
  Future<Map<String, dynamic>> addEmailToAccount(@Body() AddEmailToAccountDto dto);

  @POST(path: '/login-with-email')
  Future<Map<String, dynamic>> loginWithEmail(@Body() LoginWithEmailDto dto);

  @POST(path: '/reset-pin')
  Future<Map<String, dynamic>> resetPin(@Body() ResetCodePinDto dto);

  @POST(path: '/logout')
  Future<Map<String, dynamic>> logout(
      );

  @POST(path: '/request-deletion')
  Future<Map<String, dynamic>> requestDeletion();

  @POST(path: '/cancel-deletion')
  Future<Map<String, dynamic>> cancelDeletion();
}
