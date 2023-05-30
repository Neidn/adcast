import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/services/auth_service.dart';

import '/app/routes/app_pages.dart';

import '/app/data/model/api/api_result.dart';
import '/app/data/model/api/api_response.dart';

import '/app/data/model/user/user_response_data.dart';

import '/app/storage/device/device_token_storage.dart';
import '/app/storage/device/device_id_storage.dart';
import '/app/data/model/campaign/campaign_data.dart';
import '/app/data/model/campaign/group_data.dart';
import '/app/storage/db/campaigns_table.dart';
import '/app/storage/db/groups_table.dart';
import '/app/data/model/user/user_info_data.dart';

import '/app/storage/db/user_info_table.dart';

import '/app/utils/global_variables.dart';

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

      // Save Access Token To Storage
      AuthService.to.setDeviceToken(userResponseData.accessToken ?? '');

      if (deviceTokenStorage.emptyDeviceTokenCheck() == true) {
        throw Exception('Try Again');
      }

      // Save User info To Database
      UserInfoTable userInfoTable = UserInfoTable(appUserInfoTable);
      int result = await userInfoTable.userInfoInsert(
        UserInfoData(
          userId: id,
          userName: userResponseData.username,
          userStatus: userResponseData.customer!['status'],
          customerKey: userResponseData.customer!['id'],
        ),
      );

      if (result == 0) {
        throw Exception('Try Again');
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

      // Save Campaign Data To Database
      List<CampaignData> campaignListData = [];

      // Save Group Data To Database
      List<GroupData> groupListData = [];

      for (var campaignData in campaignResult.data!.entries) {
        String campaignKey = campaignData.key;

        Map<String, dynamic> groupData = campaignData.value['group'];

        campaignData.value['campaign_key'] = campaignKey;
        campaignData.value['campaign_name'] = campaignData.value['name'];

        campaignData.value.remove('group');
        campaignData.value.remove('name');

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

        campaignListData.add(CampaignData.fromJson(campaignData.value));

        for (var groupData in groupResult.data!.entries) {
          String groupKey = groupData.key;
          groupData.value['group_key'] = groupKey;
          groupData.value['campaign_key'] = campaignKey;
          groupData.value['group_name'] = groupData.value['name'];

          groupData.value.remove('campaign');

          groupListData.add(GroupData.fromJson(groupData.value));
        }
      }

      // Save Campaign Data To Database
      CampaignsTable campaignsTable = CampaignsTable(appCampaignsTable);

      campaignsTable.campaignsDataInsert(campaignListData);

      // Save Group Data To Database
      GroupsTable groupsTable = GroupsTable(appGroupsTable);

      groupsTable.groupsDataInsert(groupListData);

      await AuthService.to.loginCheck();

      // Show Success SnackBar And Navigate To Main Page
      UserInfoData userInfoData = await userInfoTable.userInfoSelectOne();

      Get.snackbar(
        response.response,
        "Welcome ${userInfoData.userName}",
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
