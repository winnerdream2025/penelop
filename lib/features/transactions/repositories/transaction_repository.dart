import 'package:corrispay/features/mobiles-transactions/dto/add_mobile_money_to_wallet.dto.dart';
import 'package:corrispay/features/mobiles-transactions/responses/mobile_deposit_response.dart';
import 'package:corrispay/features/beneficiary/dto/check_qr_code_info_dto.dart';
import 'package:corrispay/features/transactions/dto/confirm-payment-request.dto.dart';
import 'package:corrispay/features/transactions/dto/withdraw_dto.dart';
import 'package:corrispay/features/transactions/models/custom_transactions_response.dart';
import 'package:corrispay/features/transactions/models/transaction.dart';
import 'package:riverpod/riverpod.dart';
import 'package:chopper/chopper.dart';
import '../../../core/api_responses/api_response.model.dart';
import '../../../core/utils/types.dart';
import '../../intern-transactions/responses/check_qr_code_transfer_info_response.dart';
import '../../intern-transactions/responses/confirm_transaction_response.dart';
import '../../intern-transactions/responses/intern_transaction_response.dart';
import '../../../core/network/network_module.dart';
import '../../mobiles-transactions/responses/withdrawal_response.dart';
import '../dto/create_intern_transaction.dto.dart';
import '../dto/confirm_intern_transaction.dto.dart';
import '../models/country_operator_model.dart';
import '../services/transaction.service.dart';

class TransactionRepository {
  final TransactionService transactionService;

  TransactionRepository(this.transactionService);

  Future<List<CountryOperatorModel>?> getCountriesWithMobileMoneys(
    OperationType operationType,
  ) async {
    try {
      final response = await transactionService.getCountriesWithMobileMoney(
       operationType.toString().split('.').last,
      );
      print(response);

      return (response)
          .map((countryJson) => CountryOperatorModel.fromJson(countryJson))
          .toList();
    } catch (e) {
      print('getCountriesWithMobileMoneys error: $e');
      return null;
    }
  }

  Future<CustomTransactionsResponse?> getTransactions({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await transactionService.getTransactions(page, limit);
      print(response);

      return CustomTransactionsResponse.fromJson(response);
    } catch (e) {
      print('getTransactions error: $e');
      return null;
    }
  }


  Future<InternTransactionResponse?> createInternTransaction(
    CreateInternTransactionDto dto,
  ) async {
    try {
      final response = await transactionService.createInternTransaction(dto);
      print(response);
      return InternTransactionResponse.fromJson(response);
    } catch (e) {
      print('createInternTransaction error: $e');
      return null;
    }
  }

  Future<ConfirmTransactionResponse?> confirmInternTransaction(
    ConfirmInternTransactionDto dto,
  ) async {
    try {
      print(dto.toJson());
      final response = await transactionService.confirmInternTransaction(dto);
      print(response);
      return ConfirmTransactionResponse.fromJson(response);
    } catch (e) {
      print('confirmInternTransaction error: $e');
      return null;
    }
  }

  Future<WithdrawalResponse?> withdrawMoneyToMobileMoney(
    WithdrawDto dto,
  ) async {
    try {
      print(dto.toJson());
      final response = await transactionService.withdrawMoneyToMobileMoney(dto);
      print(response);
      return WithdrawalResponse.fromJson(response);
    } catch (e) {
      print('createInternTransaction error: $e');
      return null;
    }
  }

  Future<ConfirmTransactionResponse?> confirmWithdrawMoneyToMobileMoney(
    ConfirmInternTransactionDto dto,
  ) async {
    try {
      final response = await transactionService
          .confirmWithdrawMoneyToMobileMoney(dto);
      print(response);
      return ConfirmTransactionResponse.fromJson(response);
    } catch (e) {
      print('confirm error: $e');
      return null;
    }
  }

  Future<MobileDepositResponse?> addMobileMoneyToWallet(
    AddMobileMoneyToWalletDto dto,
  ) async {
    try {
      print(dto.toJson());
      final response = await transactionService.addMobileMoneyToWallet(dto);
      print(response);
      return MobileDepositResponse.fromJson(response);
    } catch (e) {
      print(' $e');
      return null;
    }
  }

  Future<CheckQrCodeTransferInfoResponse?> checkQrCodeInfo(
    CheckQrCodeInfoDto dto,
  ) async {
    try {
      print(dto.toJson());
      final response = await transactionService.chekQrCodeInfo(dto);
      print(response);
      return CheckQrCodeTransferInfoResponse.fromJson(response);
    } catch (e) {
      print(' $e');
      return null;
    }
  }

}

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  final transactionService = chopperClient.getService<TransactionService>();
  return TransactionRepository(transactionService);
});
