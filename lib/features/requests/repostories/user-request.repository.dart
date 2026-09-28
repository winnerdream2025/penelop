import 'package:corrispay/core/api_responses/api_response.model.dart';
import 'package:corrispay/features/requests/dto/confirm-request.dto.dart';
import 'package:corrispay/features/requests/models/requests.response.dart';
import 'package:corrispay/features/requests/services/user-request.service.dart';
import 'package:riverpod/riverpod.dart';
import '../../../core/network/network_module.dart';

class UserRequestRepository {
  final UserRequestService userRequestService;

  UserRequestRepository(this.userRequestService);

  Future<RequestsResponse?> getMyRequests() async {
    try {
      final response = await userRequestService.getRequests();
      return RequestsResponse.fromJson(response);
    } catch (e) {
      print('getMyRequests error: $e');
      return null;
    }
  }

  Future<ApiResponse?> confirmRequest(ConfirmRequestDto dto) async {
    try {
      final response = await userRequestService.confirmRequest(dto);
      return ApiResponse.fromJson(response);
    } catch (e) {
      print('getMyRequests error: $e');
      return null;
    }
  }

  Future<ApiResponse?> rejectRequest(String requestId) async {
    try {
      final response = await userRequestService.rejectRequest(requestId);
      return ApiResponse.fromJson(response);
    } catch (e) {
      print('getMyRequests error: $e');
      return null;
    }
  }
}

final userRequestRepositoryProvider = Provider<UserRequestRepository>((ref) {
  final userRequestService = chopperClient.getService<UserRequestService>();
  return UserRequestRepository(userRequestService);
});
