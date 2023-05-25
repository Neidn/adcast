import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '/app/routes/app_pages.dart';

import '/app/utils/global_variables.dart';

import '/app/data/model/api/api_auth.dart';
import '/app/data/model/api/api_response.dart';

import '/app/data/repository/api_auth_impl.dart';

import '/app/storage/device/device_token_storage.dart';

import '/app/storage/db/campaigns_table.dart';
import '/app/storage/db/groups_table.dart';
import '/app/storage/db/keyword_info_table.dart';
import '/app/storage/db/keywords_table.dart';
import '/app/storage/db/user_info_table.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  // Database table
  final UserInfoTable userInfoTable = UserInfoTable(appUserInfoTable);
  final CampaignsTable campaignsTable = CampaignsTable(appCampaignsTable);
  final GroupsTable groupsTable = GroupsTable(appGroupsTable);
  final KeywordInfoTable keywordInfoTable =
      KeywordInfoTable(appKeywordInfoTable);
  final KeywordsTable keywordsTable = KeywordsTable(appKeywordsTable);

  // Authenticated
  final RxBool _authenticated = false.obs;

  bool get authenticated => _authenticated.value;

  set authenticated(value) => _authenticated.value = value;

  // loading
  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set isLoading(bool value) => _isLoading.value = value;

  // Device Token
  final RxString _deviceToken = ''.obs;

  String get deviceToken => _deviceToken.value;

  set deviceToken(String value) => _deviceToken.value = value;

  @override
  void onInit() async {
    try {
      // User Login Check
      await sessionDeviceToken();
      if (authenticated == false) {
        await logout();
      }
    } catch (e) {
      await logout();
    }

    super.onInit();
  }

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    super.onReady();
  }

  Future<void> logout() async {
    authenticated = false;

    // Campaign Storage
    await campaignsTable.deleteAll();
    await groupsTable.deleteAll();

    // Device Storage
    resetDeviceToken();

    // Keyword Storage
    await keywordsTable.deleteAll();
    await keywordInfoTable.deleteAll();

    // User Storage
    await userInfoTable.deleteAll();

    Get.offAllNamed(Routes.login);
  }

  // login check
  Future<void> loginCheck() async {
    try {
      int userInfoCount = await userInfoTable.queryRowCount();

      if (deviceTokenStorage.emptyDeviceTokenCheck() == true ||
          userInfoCount != 1) {
        authenticated = false;
      } else {
        authenticated = true;
      }
    } catch (e) {
      authenticated = false;
    }
  }

  void resetDeviceToken() {
    deviceToken = '';
    deviceTokenStorage.deviceToken = '';
  }

  void setDeviceToken(String value) {
    deviceToken = value;
    deviceTokenStorage.deviceToken = value;
  }

  Future<void> sessionDeviceToken() async {
    isLoading = true;
    ApiAuthImpl apiAuthImpl = ApiAuthImpl();

    try {
      if (deviceToken.isEmpty == true) {
        throw Exception('Empty Device Token');
      }

      ApiResponse apiResponse = await apiAuthImpl.getSessionCheck(deviceToken);

      if (apiResponse.apiResponseEmptyCheck() == true) {
        throw Exception('Empty Response');
      }

      ApiAuth apiAuth = ApiAuth.fromJson(apiResponse.data);

      if (apiAuth.isEmpty == true) {
        throw Exception('Empty Response');
      }

      if (apiAuth.logoutCheck(apiResponse.response) == true) {
        await logout();
      }

      setDeviceToken(apiAuth.deviceToken ?? '');

      if (deviceTokenStorage.emptyDeviceTokenCheck() == true) {
        await logout();
      }
    } catch (e) {
      await logout();
    } finally {
      isLoading = false;
    }
  }
}
