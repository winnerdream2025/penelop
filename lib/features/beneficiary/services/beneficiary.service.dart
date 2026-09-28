import 'package:corrispay/features/beneficiary/dto/add_beneficiary.dto.dart';
import 'dart:async';
import 'package:chopper/chopper.dart';
import 'package:corrispay/features/beneficiary/dto/get-receiver-suggestions.dto.dart';
part 'beneficiary.service.chopper.dart';

@ChopperApi(baseUrl: '/beneficiary')
abstract class BeneficiaryService extends ChopperService {
  static BeneficiaryService create([ChopperClient? client]) =>
      _$BeneficiaryService(client);

  @POST(path: '/receiver-suggestions')
  Future<Map<String, dynamic>> getBeneficiaries(
    @Body() GetReceiverSuggestionsDto dto,
  );

  @POST()
  Future<Map<String, dynamic>> addBeneficiary(@Body() AddBeneficiaryDto dto);

  @GET(path: '/{id}')
  Future<Map<String, dynamic>> getBeneficiaryById(@Path('id') String id);

  @GET(path: 'check-beneficiary/{phoneNumber}')
  Future<Map<String, dynamic>> checkBeneficiary(
    @Path('phoneNumber') String phoneNumber,
  );


  @GET(path: '/check-beneficiary-qrcode/{beneficiaryId}')
  Future<Map<String, dynamic>> checkBeneficiaryByQrCode(
      @Path('beneficiaryId') String beneficiaryId,
      );

}
