import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '/app/routes/app_pages.dart';

import '/app/storage/user/customer_data_storage.dart';
import '/app/storage/user/user_data_storage.dart';

import '/app/storage/device/device_token_storage.dart';

import '/app/storage/campaign/campaign_list_data_storage.dart';
import '/app/storage/campaign/group_list_data_storage.dart';

import '/app/storage/keyword/keyword_info_storage.dart';
import '/app/storage/keyword/keyword_list_data_storage.dart';

class AuthService extends GetxService {
  // Authenticated
  final RxBool _authenticated = false.obs;

  bool get authenticated => _authenticated.value;

  set authenticated(value) => _authenticated.value = value;

  @override
  void onInit() async {
    // User Data Check
    try {
      if (checkAllStorage() == true) {
        login();
      } else {
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

  void login() {
    authenticated = true;
  }

  Future<void> logout() async {
    // Campaign Storage
    await campaignListDataStorage.resetCampaignListData();
    await groupListDataStorage.resetGroupListData();

    // Device Storage
    await deviceTokenStorage.resetDeviceToken();

    // Keyword Storage
    await keywordListDataStorage.resetKeywordListData();
    await keywordInfoStorage.resetKeywordInfo();

    // User Storage
    await userDataStorage.resetUserData();
    await customerDataStorage.resetCustomerData();

    loginCheck();

    if (authenticated == false) {
      Get.offAllNamed(Routes.login);
    }
  }

  // login check
  void loginCheck() {
    try {
      if (deviceTokenStorage.emptyDeviceTokenCheck() == true ||
          userDataStorage.emptyUserDataCheck() == true) {
        authenticated = false;
      } else {
        authenticated = true;
      }
    } catch (e) {
      authenticated = false;
    }
  }

  bool checkAllStorage() {
    if (userDataStorage.emptyUserDataCheck() == false &&
        customerDataStorage.emptyCustomerDataCheck() == false &&
        campaignListDataStorage.emptyCampaignListDataCheck() == false &&
        groupListDataStorage.emptyGroupListDataCheck() == false) {
      return true;
    } else {
      return false;
    }
  }
}
