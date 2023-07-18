import 'package:adcast/app/controller/payment/payment_controller.dart';
import 'package:adcast/app/data/model/api/api_response.dart';
import 'package:adcast/app/data/model/payment/bid_data.dart';
import 'package:adcast/app/data/model/payment/good_data.dart';
import 'package:adcast/app/data/model/user/user_api_data.dart';
import 'package:adcast/app/data/repository/api_bid_info_impl.dart';
import 'package:adcast/app/storage/db/bid_info_table.dart';
import 'package:adcast/app/storage/db/user_api_table.dart';
import 'package:adcast/app/storage/device/device_token_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/storage/db/user_info_table.dart';
import '/app/storage/db/campaigns_table.dart';
import '/app/storage/db/groups_table.dart';

import '/app/controller/main/main_controller.dart';

import '/app/utils/global_variables.dart';

import '/app/data/model/user/user_info_data.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();

  // Database Table
  UserInfoTable userInfoTable = UserInfoTable(appUserInfoTable);
  GroupsTable groupsTable = GroupsTable(appGroupsTable);
  CampaignsTable campaignsTable = CampaignsTable(appCampaignsTable);
  BidInfoTable bidInfoTable = BidInfoTable(appBidInfoTable);
  UserApiTable userApiTable = UserApiTable(appUserApiTable);

  // UserInfo
  final Rx<UserInfoData> _userInfoData = UserInfoData().obs;

  UserInfoData get userInfoData => _userInfoData.value;

  set userInfoData(UserInfoData value) => _userInfoData.value = value;

  // Bid Count
  final Rx<BidData> _bidData = BidData().obs;

  BidData get bidData => _bidData.value;

  set bidData(BidData value) => _bidData.value = value;

  // Max Bid Count
  final Rx<BidData> _maxBidData = BidData().obs;

  BidData get maxBidData => _maxBidData.value;

  set maxBidData(BidData value) => _maxBidData.value = value;

  // UserApi Data List
  final RxList<UserApiData> _userApiDataList = <UserApiData>[].obs;

  List<UserApiData> get userApiDataList => _userApiDataList;

  set userApiDataList(List<UserApiData> value) =>
      _userApiDataList.value = value;

  // loading
  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set isLoading(bool value) => _isLoading.value = value;

  @override
  void onInit() async {
    userInfoData = await userInfoTable.userInfoSelectOne();
    await getBidInfo();
    await getUserApiList();
    super.onInit();
  }

  void toggleThemeMode() async {
    MainController.to.isDarkMode = !MainController.to.isDarkMode;
    Get.changeThemeMode(
      MainController.to.isDarkMode ? ThemeMode.dark : ThemeMode.light,
    );
  }

  Future<BidData> getMaxBidInfo() async {
    var goodDataList = await PaymentController.to.getGoodsAllData();

    // Get GoodData.bid which is same as UserInfoData.goods
    var goodData = goodDataList.firstWhere(
      (element) => element.name == userInfoData.goods,
      orElse: () => GoodData(
        name: '3',
        total: '1',
        three: '1',
        five: '1',
        ten: '1',
        thirty: '1',
      ),
    );

    return BidData(
      total: "${goodData.total ?? 1}",
      three: "${goodData.three ?? 1}",
      five: "${goodData.five ?? 1}",
      ten: "${goodData.ten ?? 1}",
      thirty: "${goodData.thirty ?? 1}",
    );
  }

  Future<void> getBidInfo() async {
    try {
      isLoading = true;
      final String deviceToken = await deviceTokenStorage.getDeviceToken();
      if (deviceToken.isEmpty) {
        return;
      }

      final String userId = userInfoData.userId ?? '';

      if (userId.isEmpty) {
        return;
      }

      final ApiBidCycleImpl apiBidCycleImpl = ApiBidCycleImpl();

      ApiResponse apiResponse = await apiBidCycleImpl.getBidInfo(
        deviceToken,
        userId,
      );
      if (apiResponse.apiResponseEmptyCheck() == true) {
        throw Exception(apiResponse.response);
      }

      BidData newBidData = BidData(
        total: "${apiResponse.data['total']}",
        three: "${apiResponse.data['value']['3'] ?? '0'}",
        five: "${apiResponse.data['value']['5'] ?? '0'}",
        ten: "${apiResponse.data['value']['10'] ?? '0'}",
        thirty: "${apiResponse.data['value']['30'] ?? '0'}",
      );

      await bidInfoTable.bidInfoDataInsert(newBidData);
      bidData = newBidData;
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading = false;
    }
  }

  Future<void> getUserApiList() async {
    isLoading = true;
    try {
      userApiDataList = await userApiTable.getUserApiListData();
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading = false;
    }
  }
}
