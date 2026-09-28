import 'package:corrispay/features/intern-transactions/responses/intern_transaction_response.dart';
import 'package:corrispay/features/beneficiary/dto/check_qr_code_info_dto.dart';
import 'package:corrispay/features/transactions/dto/withdraw_dto.dart';
import 'package:corrispay/features/transactions/models/custom_transactions_response.dart';
import 'package:riverpod/riverpod.dart';
import '../../../core/utils/types.dart';
import '../../intern-transactions/responses/check_qr_code_transfer_info_response.dart';
import '../../intern-transactions/responses/confirm_transaction_response.dart';
import '../../mobiles-transactions/responses/withdrawal_response.dart';
import '../dto/create_intern_transaction.dto.dart';
import '../dto/confirm_intern_transaction.dto.dart';
import '../models/country_operator_model.dart';
import '../repositories/transaction_repository.dart';

final createInternTransactionProvider =
    FutureProvider.family<
      InternTransactionResponse?,
      CreateInternTransactionDto
    >((ref, createInternTransactionDto) async {
      final transactionRepository = ref.watch(transactionRepositoryProvider);
      final response = await transactionRepository.createInternTransaction(
        createInternTransactionDto,
      );
      return response;
    });

final confirmInternTransactionProvider =
    FutureProvider.family<
      ConfirmTransactionResponse?,
      ConfirmInternTransactionDto
    >((ref, confirmInternTransactionDto) async {
      final transactionRepository = ref.watch(transactionRepositoryProvider);
      final response = await transactionRepository.confirmInternTransaction(
        confirmInternTransactionDto,
      );

      return response;
    });

final withdrawMoneyToMobileMoneyProvider =
    FutureProvider.family<WithdrawalResponse?, WithdrawDto>((ref, dto) async {
      final transactionRepository = ref.watch(transactionRepositoryProvider);
      final response = await transactionRepository.withdrawMoneyToMobileMoney(
        dto,
      );

      return response;
    });

final confirmWithdrawMoneyToMobileMoneyProvider =
    FutureProvider.family<
      ConfirmTransactionResponse?,
      ConfirmInternTransactionDto
    >((ref, dto) async {
      final transactionRepository = ref.watch(transactionRepositoryProvider);

      final response = await transactionRepository
          .confirmWithdrawMoneyToMobileMoney(dto);

      return response;
    });

final checkQrCodeInfoProvider =
    FutureProvider.family<CheckQrCodeTransferInfoResponse?, CheckQrCodeInfoDto>(
      (ref, dto) async {
        final transactionRepository = ref.watch(transactionRepositoryProvider);
        final response = await transactionRepository.checkQrCodeInfo(dto);

        return response;
      },
    );

final getCountriesWithMobileMoneyProvider =
    FutureProvider.family<List<CountryOperatorModel>?, OperationType>((
      ref,
      type,
    ) async {
      final countryRepository = ref.watch(transactionRepositoryProvider);
      final countries = await countryRepository.getCountriesWithMobileMoneys(
        type,
      );
      return countries;
    });

