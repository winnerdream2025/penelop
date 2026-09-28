import 'package:corrispay/features/requests/dto/confirm-request.dto.dart';
import 'package:corrispay/features/transactions/dto/confirm-payment-request.dto.dart';
import "dart:async";
import 'package:chopper/chopper.dart';
part 'user-request.service.chopper.dart';

@ChopperApi(baseUrl: '/user-requests')
abstract class UserRequestService extends ChopperService {
  static UserRequestService create([ChopperClient? client]) =>
      _$UserRequestService(client);

  @POST(path: '/confirm')
  Future<Map<String, dynamic>> confirmRequest(
      @Body() ConfirmRequestDto dto,
      );

  @PATCH(path: '/{id}/reject')
  Future<Map<String, dynamic>> rejectRequest(@Path('id') String id);


  @GET(path: '/me')
  Future<Map<String, dynamic>> getRequests(
      );
}
