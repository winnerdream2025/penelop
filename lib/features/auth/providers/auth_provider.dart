import 'package:corrispay/core/local/business_settings_local_provider.dart';
import 'package:corrispay/features/account/dto/add_email_to_account.dto.dart';
import 'package:corrispay/features/auth/dto/login_phone.dto.dart';
import 'package:corrispay/features/auth/dto/login_with_email.dto.dart';
import 'package:corrispay/features/auth/dto/login_with_pin_dto.dart';
import 'package:corrispay/features/auth/dto/register.dto.dart';
import 'package:corrispay/features/auth/dto/reset-code-pin.dto.dart';
import 'package:corrispay/features/auth/dto/reset_password_dto.dart';
import 'package:corrispay/features/auth/dto/reset_password_email.dto.dart';
import 'package:corrispay/features/account/dto/set_pin.dto.dart';
import 'package:corrispay/features/account/dto/update_password_dto.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:riverpod/riverpod.dart';
import '../../../core/api_responses/api_response.model.dart';
import '../../../core/api_responses/deletion_status_response.dart';
import '../../../core/local/merchant_account.provider.dart';
import '../responses/auth_api_response.dart';
import '../../intern-transactions/responses/beneficiary_response.dart';
import '../../../core/api_responses/common_string_response.dart';
import '../../../core/local/userlocal_provider.dart';
import '../../../core/network/firebase_service.dart';
import '../dto/create_update_pin.dto.dart';
import '../repositories/auth_repository.dart';

final registerProvider = FutureProvider.family<AuthResponse?, RegisterDto>((
  ref,
  registerDto,
) async {
  final authRepository = ref.watch(authRepositoryProvider);
  final response = await authRepository.register(registerDto);
  if (response != null && response.data != null) {
    ref.read(userLocalProvider.notifier).saveUser(response.data!.user);
    ref
        .read(businessSettingsLocalProvider.notifier)
        .saveSettings(response.data!.businessSettings);
  }
  return response;
});

final loginPhoneProvider = FutureProvider.family<AuthResponse?, LoginPhoneDto>((
  ref,
  loginPhoneDto,
) async {
  final authRepository = ref.watch(authRepositoryProvider);
  final response = await authRepository.loginWithPhone(loginPhoneDto);

  if (response != null && response.data != null) {
    ref.read(userLocalProvider.notifier).saveUser(response.data!.user);
    ref
        .read(businessSettingsLocalProvider.notifier)
        .saveSettings(response.data!.businessSettings);

    ref
        .read(merchantAccountLocalProvider.notifier)
        .saveMerchantAccount(response.data!.merchantAccount);
  }
  return response;
});

final loginEmailProvider =
    FutureProvider.family<AuthResponse?, LoginWithEmailDto>((
      ref,
      loginEmailDto,
    ) async {
      final authRepository = ref.watch(authRepositoryProvider);
      final response = await authRepository.loginWithEmail(loginEmailDto);

      if (response != null && response.data != null) {
        ref.read(userLocalProvider.notifier).saveUser(response.data!.user);
        ref
            .read(businessSettingsLocalProvider.notifier)
            .saveSettings(response.data!.businessSettings);

        ref
            .read(merchantAccountLocalProvider.notifier)
            .saveMerchantAccount(response.data!.merchantAccount);
      }
      return response;
    });

final addEmailProvider =
    FutureProvider.family<CommonStringResponse?, AddEmailToAccountDto>((
      ref,
      addEmailToAccountDto,
    ) async {
      final authRepository = ref.watch(authRepositoryProvider);
      final response = await authRepository.addEmailToAccount(
        addEmailToAccountDto,
      );

      if (response != null && response.data != null) {
        ref.read(userLocalProvider.notifier).addEmail(response.data!);
      }
      return response;
    });

final createOrUpdatePinProvider =
    FutureProvider.family<AuthResponse?, CreateUpdatePinDto>((
      ref,
      createUpdatePinDto,
    ) async {
      final otpRepository = ref.watch(authRepositoryProvider);
      final response = await otpRepository.createOrUpdatePin(
        createUpdatePinDto,
      );
      if (response != null && response.status == true) {
        ref.read(userLocalProvider.notifier).updateCodePin(true);
      }
      return response;
    });

final createRequiredPinProvider =
    FutureProvider.family<ApiResponse?, CreateUpdatePinDto>((
      ref,
      createUpdatePinDto,
    ) async {
      final otpRepository = ref.watch(authRepositoryProvider);
      final response = await otpRepository.createRequiredPin(
        createUpdatePinDto,
      );
      if (response != null && response.status == true) {
        ref.read(userLocalProvider.notifier).updateCodePin(true);
      }
      return response;
    });

final fcmTokenProvider = FutureProvider<String?>((ref) async {
  await FirebaseMessaging.instance.requestPermission();
  return await FirebaseService.getToken();
});

final logoutProvider = FutureProvider<void>((ref) async {
  final authRepository = ref.watch(authRepositoryProvider);
  await authRepository.logout();
});

final getUserByPhoneNumberProvider =
    FutureProvider.family<BeneficiaryResponse?, String>((
      ref,
      phoneNumber,
    ) async {
      final authRepository = ref.watch(authRepositoryProvider);
      final response = await authRepository.getUserByPhoneNumber(phoneNumber);

      return response;
    });

final updatePasswordProvider =
    FutureProvider.family<ApiResponse?, UpdatePasswordDto>((ref, dto) async {
      final authRepository = ref.watch(authRepositoryProvider);
      return await authRepository.changePassword(dto);
    });

final resetPasswordProvider =
    FutureProvider.family<ApiResponse?, ResetPasswordDto>((ref, dto) async {
      final authRepository = ref.watch(authRepositoryProvider);
      return await authRepository.resetPassword(dto);
    });

final resetPasswordEmailProvider =
    FutureProvider.family<ApiResponse?, ResetPasswordEmailDto>((
      ref,
      dto,
    ) async {
      final authRepository = ref.watch(authRepositoryProvider);
      return await authRepository.resetPasswordEmail(dto);
    });

final updateCodePinProvider = FutureProvider.family<ApiResponse?, SetPinDto>((
  ref,
  dto,
) async {
  final authRepository = ref.watch(authRepositoryProvider);
  return await authRepository.updateCodePin(dto);
});

final loginWithCodePinProvider =
    FutureProvider.family<AuthResponse?, LoginWithPinDto>((ref, dto) async {
      final authRepository = ref.watch(authRepositoryProvider);
      final response = await authRepository.loginWithPinCode(dto);
      if (response != null && response.data != null) {
        ref.read(userLocalProvider.notifier).saveUser(response.data!.user);
        ref
            .read(businessSettingsLocalProvider.notifier)
            .saveSettings(response.data!.businessSettings);

        ref
            .read(merchantAccountLocalProvider.notifier)
            .saveMerchantAccount(response.data!.merchantAccount);
      }
      return response;
    });

final resetCodePinProvider =
    FutureProvider.family<CommonStringResponse?, ResetCodePinDto>((
      ref,
      dto,
    ) async {
      final authRepository = ref.watch(authRepositoryProvider);
      final response = await authRepository.resetPinCode(dto);

      return response;
    });

final requestDeletionProvider =
    FutureProvider<DeletionStatusResponse?>((ref) async {
  final authRepository = ref.watch(authRepositoryProvider);
  final response = await authRepository.requestDeletion();
  if (response != null &&
      response.status == true &&
      response.deletionRequestedAt != null &&
      response.deletionScheduledFor != null) {
    ref.read(userLocalProvider.notifier).setDeletionStatus(
          response.deletionRequestedAt!,
          response.deletionScheduledFor!,
        );
  }
  return response;
});

final cancelDeletionProvider = FutureProvider<ApiResponse?>((ref) async {
  final authRepository = ref.watch(authRepositoryProvider);
  final response = await authRepository.cancelDeletion();
  if (response != null && response.status == true) {
    ref.read(userLocalProvider.notifier).clearDeletionStatus();
  }
  return response;
});
