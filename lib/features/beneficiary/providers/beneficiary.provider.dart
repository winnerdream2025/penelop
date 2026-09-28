import 'package:corrispay/features/beneficiary/dto/get-receiver-suggestions.dto.dart';
import 'package:corrispay/features/beneficiary/repositories/beneficiary.repository.dart';
import 'package:corrispay/features/beneficiary/responses/beneficiaries_response.model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api_responses/api_response.model.dart';
import '../../auth/repositories/auth_repository.dart';
import '../../intern-transactions/responses/beneficiary_response.dart';
import '../dto/add_beneficiary.dto.dart';
import 'devices_contacts_provider.dart';

// ── receiver_suggestions_provider.dart, mis à jour ──

final receiverSuggestionsProvider =
    FutureProvider.autoDispose<BeneficiariesResponse?>((ref) async {
      final contactsRepo = ref.watch(deviceContactsRepositoryProvider);

      List<DeviceContactEntry> contactEntries = [];
      try {
        contactEntries = await contactsRepo.getContactEntries();
      } catch (e) {
        contactEntries = [];
      }

      print(contactEntries.toList());
      final beneficiaryService = ref.read(beneficiaryRepositoryProvider);
      final response = await beneficiaryService.getBeneficiaries(
        GetReceiverSuggestionsDto(contacts: contactEntries),
      );

      return response;
    });
final addBeneficiaryProvider = FutureProvider.family<ApiResponse?, String>((
  ref,
  beneficiaryPhoneNumber,
) async {
  final response = await ref
      .watch(beneficiaryRepositoryProvider)
      .addBeneficiary(
        AddBeneficiaryDto(beneficiaryPhoneNumber: beneficiaryPhoneNumber),
      );
  return response;
});

final checkBeneficiaryByPhoneNumberProvider =
    FutureProvider.family<BeneficiaryResponse?, String>((
      ref,
      phoneNumber,
    ) async {
      return await ref
          .watch(beneficiaryRepositoryProvider)
          .checkBeneficiary(phoneNumber);
    });

final checkBeneficiaryByQrCodeProvider =
    FutureProvider.family<BeneficiaryResponse?, String>((
      ref,
      beneficiaryId,
    ) async {
      return await ref
          .watch(beneficiaryRepositoryProvider)
          .checkBeneficiaryByQrCode(beneficiaryId);
    });
