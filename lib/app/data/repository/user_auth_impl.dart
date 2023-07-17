import '/app/utils/global_variables.dart';

import '/app/data/model/user/user_auth.dart';
import '/app/data/model/api/api_response.dart';

import '/app/services/auth_service.dart';

class UserAuthImpl {
  final _client = RestClient(dio);

  Future<ApiResponse> postLogin(
    String userId,
    String userPwd,
    String deviceID,
  ) async {
    try {
      ApiResponse apiResponse =
          await _client.postLogin(userId, userPwd, deviceID);

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
        request: "Login",
        response: e.toString(),
      );
    }
  }
}
