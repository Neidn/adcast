import 'package:adcast/app/data/model/user/user_api_data.dart';
import 'package:adcast/app/storage/db/user_api_table.dart';
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
  // DB Table
  CampaignsTable campaignsTable = CampaignsTable(appCampaignsTable);
  UserInfoTable userInfoTable = UserInfoTable(appUserInfoTable);
  GroupsTable groupsTable = GroupsTable(appGroupsTable);
  UserApiTable userApiTable = UserApiTable(appUserApiTable);

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
      String deviceID = await deviceIdStorage.getDeviceId();

      ApiResponse response = await userAuthImpl.postLogin(
        id,
        password,
        deviceID,
      );

      UserResponseData userResponseData =
          UserResponseData.fromJson(response.data);

      if (userResponseData.userResponseDataEmptyCheck() == false) {
        throw Exception(response.response);
      }

      // Save Access Token To Storage
      AuthService.to.setDeviceToken(userResponseData.accessToken ?? '');

      final bool deviceTokenResult =
          await deviceTokenStorage.emptyDeviceTokenCheck();
      if (deviceTokenResult == true) {
        throw Exception('Try Again');
      }

      // Save User info To Database
      final List<UserApiData> userApiListData = [];
      for (var customer in userResponseData.customer ?? []) {
        userApiListData.add(
          UserApiData(
            status: customer['status'],
            customerId: customer['id'],
            customerName: customer['name'],
            bizmoney: customer['bizmoney'],
          ),
        );
      }

      await userApiTable.userApiInsertAll(userApiListData);

      final int result = await userInfoTable.userInfoInsert(
        UserInfoData(
          userId: userResponseData.userid,
          userName: userResponseData.username,
          goods: userResponseData.goods,
          expiryDate: userResponseData.expiryDate,
          rDay: userResponseData.rDay,
        ),
      );

      if (result == 0) {
        throw Exception('Try Again');
      }

      // Save Campaign Data To Database
      List<CampaignData> campaignListData = [];

      // Save Group Data To Database
      List<GroupData> groupListData = [];

      // parse campaign data
      for (var campaign in userResponseData.campaign ?? []) {
        // List<dynamic> to List<Map<String, dynamic>>
        final List<Map<String, dynamic>> campaignList = [];

        for (var campaignData in campaign['data'] ?? []) {
          campaignList.add(campaignData);
        }

        final ApiResult campaignResult = ApiResult(
          status: campaign['status'],
          message: campaign['message'] ?? '',
          totalResults: '${campaign['totalResults'] ?? 0}',
          data: campaignList,
        );

        if (campaignResult.apiResultEmptyCheck() == true) {
          continue;
        }

        for (var campaignData in campaignList) {
          Map<String, dynamic> group = campaignData['group'];

          campaignData['customer_id'] = campaignData['customer_id'];
          campaignData['campaign_key'] = campaignData['cid'];
          campaignData['campaign_name'] = campaignData['name'];

          campaignData.remove('name');
          campaignData.remove('group');

          campaignListData.add(CampaignData.fromJson(campaignData));

          final List<Map<String, dynamic>> groupList = [];

          for (var groupData in group['data'] ?? []) {
            groupList.add(groupData);
          }

          ApiResult groupResult = ApiResult(
            status: group['status'],
            message: group['message'] ?? '',
            totalResults: '${group['totalResults'] ?? 0}',
            data: groupList,
          );

          if (groupResult.apiResultEmptyCheck() == true) {
            continue;
          }
          for (var groupData in groupList) {
            groupData['group_key'] = groupData['grid'];
            groupData['group_name'] = groupData['name'];
            groupData['campaign_key'] = campaignData['cid'];

            groupData.remove('grid');
            groupData.remove('name');

            groupListData.add(GroupData.fromJson(groupData));
          }
        }
      }

      // Save Campaign Data To Database
      campaignsTable.campaignsDataInsert(campaignListData);

      // Save Group Data To Database
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
