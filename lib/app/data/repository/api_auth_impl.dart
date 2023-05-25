import '/app/utils/global_variables.dart';

import '/app/data/model/api/api_auth.dart';

import '/app/data/model/api/api_response.dart';

import '/app/services/auth_service.dart';

class ApiAuthImpl {
  final _client = RestClient(dio);

  Future<ApiResponse> getSessionCheck(String deviceToken) async {
    try {
      ApiResponse apiResponse = await _client.getSessionCheck(deviceToken);

      if (apiResponse.apiResponseCodeCheck() == false) {
        if (apiResponse.apiResponseLogoutCheck() == true) {
          await AuthService.to.logout();
          throw Exception("Session Expired");
        } else {
          throw Exception(apiResponse.response);
        }
      }

      if (apiResponse.apiResponseEmptyCheck() == true) {
        throw Exception('Empty Response');
      }

      return apiResponse;
    } catch (e) {
      return ApiResponse(
        responseCode: "400",
        request: 'CheckSession | $deviceToken',
        response: 'Failed Try Again',
      );
    }
  }
}
