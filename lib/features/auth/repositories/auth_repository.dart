import 'package:corrispay/features/auth/dto/reset-code-pin.dto.dart';
import 'package:corrispay/features/auth/responses/auth_api_response.dart';
import 'package:corrispay/features/account/dto/add_email_to_account.dto.dart';
import 'package:corrispay/features/auth/dto/login_with_email.dto.dart';
import 'package:corrispay/features/auth/dto/login_with_pin_dto.dart';
import 'package:corrispay/features/auth/dto/reset_password_dto.dart';
import 'package:corrispay/features/auth/dto/reset_password_email.dto.dart';
import 'package:corrispay/features/account/dto/set_pin.dto.dart';
import '../../../core/api_responses/api_response.model.dart';
import '../../../core/api_responses/deletion_status_response.dart';
import '../../beneficiary/responses/beneficiaries_response.model.dart';
import '../../intern-transactions/responses/beneficiary_response.dart';
import '../../../core/api_responses/common_string_response.dart';
import '../../../core/network/network_module.dart';
import '../../beneficiary/dto/add_beneficiary.dto.dart';
import '../dto/create_update_pin.dto.dart';
import '../dto/login_phone.dto.dart';
import '../dto/register.dto.dart';
import 'dart:async';
import 'package:riverpod/riverpod.dart';
import '../../account/dto/update_password_dto.dart';
import '../services/user_auth.service.dart';

class AuthRepository {
  final UserAuthService userAuthService;

  AuthRepository(this.userAuthService);

  Future<AuthResponse?> register(RegisterDto registerDto) async {
    try {
      final response = await userAuthService.register(registerDto);
      return AuthResponse.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<AuthResponse?> loginWithPhone(LoginPhoneDto loginPhoneDto) async {
    try {
      final response = await userAuthService.loginWithPhone(loginPhoneDto);
      print(response);
      return AuthResponse.fromJson(response);
    } catch (e) {
      print(" errer $e");
      return null;
    }
  }

  Future<CommonStringResponse?> resetPinCode(
    ResetCodePinDto resetPinCodeDto,
  ) async {
    try {
      final response = await userAuthService.resetPin(resetPinCodeDto);

      return CommonStringResponse.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<AuthResponse?> loginWithEmail(LoginWithEmailDto dto) async {
    try {
      final response = await userAuthService.loginWithEmail(dto);

      return AuthResponse.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<CommonStringResponse?> addEmailToAccount(
    AddEmailToAccountDto dto,
  ) async {
    try {
      final response = await userAuthService.addEmailToAccount(dto);

      return CommonStringResponse.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<AuthResponse?> createOrUpdatePin(
    CreateUpdatePinDto createUpdatePinDto,
  ) async {
    try {
      final response = await userAuthService.createOrUpdatePin(
        createUpdatePinDto,
      );
      return AuthResponse.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<ApiResponse?> createRequiredPin(
    CreateUpdatePinDto createUpdatePinDto,
  ) async {
    try {
      final response = await userAuthService.createRequiredPin(
        createUpdatePinDto,
      );
      return ApiResponse.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<ApiResponse?> changePassword(UpdatePasswordDto dto) async {
    try {
      final response = await userAuthService.changePassword(dto);
      return ApiResponse.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<ApiResponse?> resetPassword(ResetPasswordDto dto) async {
    try {
      final response = await userAuthService.resetPassword(dto);
      return ApiResponse.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<ApiResponse?> resetPasswordEmail(ResetPasswordEmailDto dto) async {
    try {
      final response = await userAuthService.resetPasswordEmail(dto);
      return ApiResponse.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<AuthResponse?> loginWithPinCode(LoginWithPinDto dto) async {
    try {
      final response = await userAuthService.loginWithPin(dto);
      return AuthResponse.fromJson(response);
    } catch (e) {

      print(e);
      return null;
    }
  }

  Future<ApiResponse?> updateCodePin(SetPinDto dto) async {
    try {
      final response = await userAuthService.changeCodePin(dto);
      return ApiResponse.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<ApiResponse?> addBeneficiary(
    AddBeneficiaryDto addBeneficiaryDto,
  ) async {
    try {
      final response = await userAuthService.addBeneficiary(addBeneficiaryDto);
      return ApiResponse.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<BeneficiariesResponse?> getBeneficiaries() async {
    try {
      final response = await userAuthService.getBeneficiaries();
      return BeneficiariesResponse.fromJson(response);
    } catch (e) {
      return null;
    }
  }


  Future<BeneficiaryResponse?> getUserByPhoneNumber(String phoneNumber) async {
    try {
      final response = await userAuthService.getUserByPhoneNumber(phoneNumber);
      return BeneficiaryResponse.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> logout() async {
    try {
      return userAuthService.logout();
    } catch (e) {
      return null;
    }
  }

  Future<DeletionStatusResponse?> requestDeletion() async {
    try {
      final response = await userAuthService.requestDeletion();
      return DeletionStatusResponse.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<ApiResponse?> cancelDeletion() async {
    try {
      final response = await userAuthService.cancelDeletion();
      return ApiResponse.fromJson(response);
    } catch (e) {
      return null;
    }
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final userAuthService = chopperClient.getService<UserAuthService>();
  return AuthRepository(userAuthService);
});
