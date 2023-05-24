import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/services/auth_service.dart';

import '/app/routes/app_pages.dart';

import '/app/data/model/api/api_result.dart';
import '/app/data/model/api/api_response.dart';

import '/app/data/model/user/user_data.dart';
import '/app/data/model/user/user_response_data.dart';
import '/app/data/model/user/customer_data.dart';

import '/app/data/model/campaign/campaign_data.dart';
import '/app/data/model/campaign/group_data.dart';

import '/app/storage/device/device_token_storage.dart';
import '/app/storage/device/device_id_storage.dart';
import '/app/storage/user/user_data_storage.dart';
import '/app/storage/user/customer_data_storage.dart';

import '/app/storage/campaign/campaign_list_data_storage.dart';
import '/app/storage/campaign/group_list_data_storage.dart';

import '/app/data/repository/user_auth_impl.dart';

// Request => Login
class LoginController extends GetxController {
  // Loading
  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set isLoading(bool value) => _isLoading.value = value;

  // isObscure
  final RxBool _isObscure = true.obs;

  bool get isObscure => _isObscure.value;

  set isObscure(bool value) => _isObscure.value = value;

  togglePasswordVisibility() => isObscure = !isObscure;

  // Form Key
  final Rx<GlobalKey<FormState>> _loginFormKey = GlobalKey<FormState>().obs;

  GlobalKey<FormState> get loginFormKey => _loginFormKey.value;

  set loginFormKey(value) => _loginFormKey.value = value;

  // Controller
  final Rx<TextEditingController> _idController = TextEditingController().obs;
  final Rx<TextEditingController> _passwordController =
      TextEditingController().obs;

  TextEditingController get idController => _idController.value;

  set idController(value) => _idController.value = value;

  TextEditingController get passwordController => _passwordController.value;

  set passwordController(value) => _passwordController.value = value;

  // dispose
  @override
  dispose() {
    idController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Login
  void login() async {
    UserAuthImpl userAuthImpl = UserAuthImpl();
    AuthService authService = AuthService();

    isLoading = true;

    try {
      String id = idController.text.trim();
      String password = passwordController.text.trim();
      String deviceToken = deviceIdStorage.deviceId;

      ApiResponse response = await userAuthImpl.postLogin(
        id,
        password,
        deviceToken,
      );

      UserResponseData userResponseData =
          UserResponseData.fromJson(response.data);

      if (userResponseData.userResponseDataEmptyCheck() == false) {
        throw Exception('Response Data is Empty');
      }

      // Save User Data To Storage
      userDataStorage.userData = UserData(
        userid: userResponseData.userid,
        username: userResponseData.username,
      );

      if (userDataStorage.emptyUserDataCheck() == true) {
        throw Exception('Try Again');
      }

      // Save Access Token To Storage
      deviceTokenStorage.deviceToken = userResponseData.accessToken ?? '';

      if (deviceTokenStorage.emptyDeviceTokenCheck() == true) {
        throw Exception('Try Again');
      }

      // Save Customer Data To Storage
      customerDataStorage.customerData =
          CustomerData.fromJson(userResponseData.customer!);

      if (customerDataStorage.emptyCustomerDataCheck() == true) {
        throw Exception('Try Again');
      }

      if (customerDataStorage.customerData.customerDataStatusCheck() == false) {
        throw Exception('Status is not OK');
      }

      // parse campaign data
      ApiResult campaignResult = ApiResult.fromJson(userResponseData.campaign!);

      if (campaignResult.apiResultEmptyCheck() == true) {
        throw Exception('Try Again');
      }

      if (campaignResult.apiResultStatusCheck() == false) {
        throw Exception(campaignResult.message);
      }

      if (campaignResult.dataLengthCheck() == false) {
        throw Exception('Data Fetching Error');
      }

      // Save Campaign Data To Storage
      List<CampaignData> campaignListData = [];

      // Save Group Data To Storage
      List<GroupData> groupListData = [];

      for (var data in campaignResult.data!.entries) {
        String campaignKey = data.key;
        Map<String, dynamic> groupData = data.value['group'];

        data.value['campaign_key'] = campaignKey;
        data.value.remove('group');

        // campaignListData

        ApiResult groupResult = ApiResult.fromJson(groupData);

        if (groupResult.apiResultEmptyCheck() == true) {
          throw Exception('Try Again');
        }

        if (groupResult.apiResultStatusCheck() == false) {
          throw Exception(groupResult.message);
        }

        if (groupResult.dataLengthCheck() == false) {
          throw Exception('Data Fetching Error');
        }

        campaignListData.add(CampaignData.fromJson(data.value));

        for (var data in groupResult.data!.entries) {
          String groupKey = data.key;
          data.value['group_key'] = groupKey;
          data.value['campaign_key'] = campaignKey;
          data.value.remove('campaign');
          groupListData.add(GroupData.fromJson(data.value));
        }
      }

      campaignListDataStorage.campaignListData = campaignListData;

      if (campaignListDataStorage.emptyCampaignListDataCheck() == true) {
        throw Exception('Try Again');
      }

      groupListDataStorage.groupListData = groupListData;

      if (groupListDataStorage.emptyGroupListDataCheck() == true) {
        throw Exception('Try Again');
      }

      authService.loginCheck();

      // Show Success SnackBar And Navigate To Main Page
      Get.snackbar(
        response.response,
        "Welcome ${userDataStorage.userData.username}",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 1),
      );

      Get.offAllNamed(Routes.main);
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading = false;
    }
  }
}
