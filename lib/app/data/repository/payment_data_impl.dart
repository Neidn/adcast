import 'package:adcast/app/data/model/api/api_response.dart';
import 'package:adcast/app/utils/global_variables.dart';

import 'package:adcast/app/data/model/payment/payment_data.dart';

class PaymentDataImpl {
  final _client = RestClient(dio);

  Future<ApiResponse> getPaymentGoodsList(String deviceToken) async {
    try {
      final ApiResponse apiResponse =
          await _client.getPaymentGoodsList(deviceToken);

      if (apiResponse.apiResponseCodeCheck() == false) {
        if (apiResponse.apiResponseLogoutCheck() == true) {
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
        request: "GoodsList",
        response: e.toString(),
      );
    }
  }
}
