import 'package:get/get.dart';

import '/app/data/model/api/api_auth.dart';
import '/app/data/repository/api_auth_impl.dart';
import '/app/data/model/api/api_response.dart';

import '/app/storage/device/device_token_storage.dart';

import '/app/services/auth_service.dart';

class DeviceTokenController extends GetxController {
  static DeviceTokenController get to => Get.find();

  // Device Token
  final RxString _deviceToken = ''.obs;

  String get deviceToken => _deviceToken.value;

  set deviceToken(String value) => _deviceToken.value = value;

  // Loading
  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set isLoading(bool value) => _isLoading.value = value;

  @override
  void onInit() {
    deviceToken = deviceTokenStorage.deviceToken;
    super.onInit();
  }

  void resetDeviceToken() {
    deviceToken = '';
    deviceTokenStorage.deviceToken = '';
  }

  Future<void> sessionDeviceToken() async {
    isLoading = true;
    ApiAuthImpl apiAuthImpl = ApiAuthImpl();

    try {
      ApiResponse apiResponse = await apiAuthImpl.getSessionCheck(deviceToken);

      if (apiResponse.apiResponseEmptyCheck() == true) {
        throw Exception('Empty Response');
      }

      ApiAuth apiAuth = ApiAuth.fromJson(apiResponse.data);

      if (apiAuth.isEmpty == true) {
        throw Exception('Empty Response');
      }

      if (apiAuth.logoutCheck(apiResponse.response) == true) {
        await AuthService().logout();
      }

      deviceToken = apiAuth.deviceToken ?? '';
      deviceTokenStorage.deviceToken = apiAuth.deviceToken ?? '';

      if (deviceTokenStorage.emptyDeviceTokenCheck() == true) {
        await AuthService().logout();
      }
    } catch (e) {
      await AuthService().logout();
    } finally {
      isLoading = false;
    }
  }
}
