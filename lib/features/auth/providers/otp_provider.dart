import 'package:corrispay/features/account/dto/send-email-otp.dto.dart';
import 'package:corrispay/features/auth/dto/send-phone-otp.dto.dart';
import 'package:corrispay/features/auth/dto/verify_otp.dto.dart';
import 'package:riverpod/riverpod.dart';
import '../../../core/api_responses/api_response.model.dart';
import '../repositories/otp_repository.dart';

// Provider pour l'envoi du code OTP
final sendCodeProvider = FutureProvider.family<ApiResponse?, SendPhoneOtpDto>((ref, sendPhoneOtpDto) async {
  final otpRepository = ref.watch(otpRepositoryProvider);
  return await otpRepository.sendPhoneOtp(sendPhoneOtpDto, 'en'); // Langue par exemple
});

// Provider pour la vérification du code OTP
final verifyCodeProvider = FutureProvider.family<ApiResponse?, VerifyOtpDto>((ref, verifyOtpDto) async {
  final otpRepository = ref.watch(otpRepositoryProvider);
  return await otpRepository.verifyOtp(verifyOtpDto, 'fr'); // Langue par exemple
});

final sendResetPasswordCodeProvider = FutureProvider.family<ApiResponse?, SendPhoneOtpDto>((ref, sendPhoneOtpDto) async {
  final otpRepository = ref.watch(otpRepositoryProvider);
  return await otpRepository.sendResetPhoneOtp(sendPhoneOtpDto); // Langue par exemple
});

// Provider pour l'envoi du code OTP
final sendEmailCodeProvider = FutureProvider.family<ApiResponse?,SendEmailOtpDto>((ref, sendEmailOtpDto) async {
  final otpRepository = ref.watch(otpRepositoryProvider);
  return await otpRepository.sendEmailOtp(sendEmailOtpDto); // Langue par exemple
});



final sendEmailResetPasswordCodeProvider = FutureProvider.family<ApiResponse?, SendEmailOtpDto>((ref, sendEmailOtpDto) async {
  final otpRepository = ref.watch(otpRepositoryProvider);
  return await otpRepository.sendResetEmailOtp(sendEmailOtpDto); // Langue par exemple
});

