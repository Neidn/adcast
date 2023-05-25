import '/app/utils/global_variables.dart';

import '/app/data/model/api/api_ad_keyword_request.dart';

import '/app/data/model/api/api_ad_keyword_response.dart';

import '/app/services/auth_service.dart';

class AdKeywordImpl {
  final _client = RestClient(dio);

  Future<ApiAdKeywordResponse> getKeyword(
    String deviceToken,
    String cid,
    String camId,
    String grId,
    String pageSize,
    String page,
  ) async {
    try {
      await AuthService.to.sessionDeviceToken();

      ApiAdKeywordResponse apiAdKeywordResponse = await _client.getKeyword(
          deviceToken, cid, camId, grId, pageSize, page);

      if (apiAdKeywordResponse.apiResponseCodeCheck() == false) {
        if (apiAdKeywordResponse.apiResponseLogoutCheck() == true) {
          await AuthService.to.logout();
          throw Exception("Session Expired");
        } else {
          throw Exception(apiAdKeywordResponse.response);
        }
      }

      if (apiAdKeywordResponse.apiResponseEmptyCheck() == true) {
        throw Exception('Empty Response');
      }

      return apiAdKeywordResponse;
    } catch (e) {
      return ApiAdKeywordResponse(
        responseCode: "400",
        request: "AD",
        response: e.toString(),
      );
    }
  }
}
