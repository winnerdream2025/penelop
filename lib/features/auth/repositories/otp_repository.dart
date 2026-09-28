import 'package:corrispay/features/account/dto/send-email-otp.dto.dart';
import '../../../core/api_responses/api_response.model.dart';
import '../../../core/network/network_module.dart';
import '../dto/send-phone-otp.dto.dart';
import '../dto/verify_otp.dto.dart';
import 'package:riverpod/riverpod.dart'; // Utilisation de riverpod sans annotation

import '../services/otp_service.dart';

class OtpRepository {
  final OtpService otpService;

  OtpRepository(this.otpService);


  Future<ApiResponse?> sendPhoneOtp(SendPhoneOtpDto sendPhoneOtpDto, String lang) async {
    try {
      print(sendPhoneOtpDto.toJson());
      final response = await otpService.sendPhoneOtp(sendPhoneOtpDto,lang);
      print(response);
      return ApiResponse.fromJson(response);
    } catch (e) {
      print(e);
      // Gérer les erreurs ici
      return null;
    }
  }


  Future<ApiResponse?> sendEmailOtp(SendEmailOtpDto dto) async {
    try {
      final response = await otpService.sendEmailOtp(dto);
      print(response);
      return ApiResponse.fromJson(response);
    } catch (e) {
      print(e);
      // Gérer les erreurs ici
      return null;
    }
  }


  Future<ApiResponse?> sendResetEmailOtp(SendEmailOtpDto dto) async {
    try {
      final response = await otpService.sendEmailResetOtp(dto);
      print(response);
      return ApiResponse.fromJson(response);
    } catch (e) {
      print(e);
      // Gérer les erreurs ici
      return null;
    }
  }

  Future<ApiResponse?> sendResetPhoneOtp(SendPhoneOtpDto sendPhoneOtpDto) async {
    try {
      final response = await otpService.sendResetOtp(sendPhoneOtpDto);
      print(response);
      return ApiResponse.fromJson(response);
    } catch (e) {
      print(e);
      // Gérer les erreurs ici
      return null;
    }
  }

  Future<ApiResponse?> verifyOtp(VerifyOtpDto verifyOtpDto, String lang) async {
    try {
      final response = await otpService.verifyOtp(verifyOtpDto, lang);
      print(response);
      return ApiResponse.fromJson(response);
    } catch (e) {
      // Gérer les erreurs ici
      return null;
    }
  }
}

// Définition du provider pour OtpRepository
final otpRepositoryProvider = Provider<OtpRepository>((ref) {
  final otpService = chopperClient.getService<OtpService>();
  return OtpRepository(otpService);
});
