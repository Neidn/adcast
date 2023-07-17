import 'package:adcast/app/data/model/api/api_response.dart';
import 'package:adcast/app/services/auth_service.dart';
import 'package:adcast/app/utils/global_variables.dart';

import '../model/api/api_bid_info.dart';

class ApiBidCycleImpl {
  final _client = RestClient(dio);

  Future<ApiResponse> getBidInfo(
    String deviceToken,
    String userId,
  ) async {
    try {
      ApiResponse apiResponse = await _client.getBidInfo(
        deviceToken,
        userId,
      );

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
        request: e.toString(),
        response: 'Failed Try Again',
      );
    }
  }
}
