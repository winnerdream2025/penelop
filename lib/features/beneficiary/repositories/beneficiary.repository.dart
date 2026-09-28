import 'package:corrispay/features/beneficiary/dto/get-receiver-suggestions.dto.dart';
import 'package:corrispay/features/beneficiary/services/beneficiary.service.dart';
import 'package:corrispay/features/intern-transactions/responses/beneficiary_response.dart';
import '../../../core/api_responses/api_response.model.dart';
import '../responses/beneficiaries_response.model.dart';
import '../../../core/network/network_module.dart';
import '../../beneficiary/dto/add_beneficiary.dto.dart';
import 'dart:async';
import 'package:riverpod/riverpod.dart';

class BeneficiaryRepository {
  final BeneficiaryService beneficiaryService;

  BeneficiaryRepository(this.beneficiaryService);

  Future<ApiResponse?> addBeneficiary(
    AddBeneficiaryDto addBeneficiaryDto,
  ) async {
    try {
      final response = await beneficiaryService.addBeneficiary(
        addBeneficiaryDto,
      );
      return ApiResponse.fromJson(response);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<BeneficiaryResponse?> checkBeneficiary(String phoneNumber) async {
    try {
      final response = await beneficiaryService.checkBeneficiary(phoneNumber);
      return BeneficiaryResponse.fromJson(response);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<BeneficiariesResponse?> getBeneficiaries(
    GetReceiverSuggestionsDto dto,
  ) async {
    try {
      final response = await beneficiaryService.getBeneficiaries(dto);
      print(response);
      return BeneficiariesResponse.fromJson(response);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<BeneficiaryResponse?> checkBeneficiaryByQrCode(String beneficiaryId) async {
    try {
      final response = await beneficiaryService.checkBeneficiaryByQrCode(beneficiaryId);
      return BeneficiaryResponse.fromJson(response);
    } catch (e) {
      return BeneficiaryResponse(message: e.toString(), status: false);
    }
  }

}

final beneficiaryRepositoryProvider = Provider<BeneficiaryRepository>((ref) {
  final beneficiaryService = chopperClient.getService<BeneficiaryService>();
  return BeneficiaryRepository(beneficiaryService);
});
