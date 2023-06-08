import 'package:adcast/app/ui/default/main/page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/storage/db/user_info_table.dart';
import '/app/storage/db/campaigns_table.dart';
import '/app/storage/db/groups_table.dart';

import '/app/controller/main/main_controller.dart';

import '/app/utils/global_variables.dart';

import '/app/data/model/user/user_info_data.dart';
import '/app/data/model/campaign/campaign_data.dart';
import '/app/data/model/campaign/group_data.dart';

class ProfileController extends GetxController {

  // Database Table
  UserInfoTable userInfoTable = UserInfoTable(appUserInfoTable);
  GroupsTable groupsTable = GroupsTable(appGroupsTable);
  CampaignsTable campaignsTable = CampaignsTable(appCampaignsTable);

  // UserInfo
  final Rx<UserInfoData> _userInfoData = UserInfoData().obs;

  UserInfoData get userInfoData => _userInfoData.value;

  set userInfoData(UserInfoData value) => _userInfoData.value = value;

  // Campaign Group Map
  final RxMap<CampaignData, List<GroupData>> _campaignGroupMap =
      <CampaignData, List<GroupData>>{}.obs;

  Map<CampaignData, List<GroupData>> get campaignGroupMap => _campaignGroupMap;

  set campaignGroupMap(value) => _campaignGroupMap.value = value;

  // loading
  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set isLoading(bool value) => _isLoading.value = value;

  // Campaign Count
  final RxInt _campaignCount = 0.obs;

  int get campaignCount => _campaignCount.value;

  set campaignCount(int value) => _campaignCount.value = value;

  // Group Count
  final RxInt _groupCount = 0.obs;

  int get groupCount => _groupCount.value;

  set groupCount(int value) => _groupCount.value = value;

  @override
  void onInit() async {
    super.onInit();
    userInfoData = await userInfoTable.userInfoSelectOne();
    await getCampaignGroupMap();
    isLoading = false;
    campaignCount = campaignGroupMap.length;
    groupCount = campaignGroupMap.values
        .map((List<GroupData> e) => e.length)
        .reduce((int value, int element) => value + element);
  }

  void toggleThemeMode() async {
    MainController.to.isDarkMode = !MainController.to.isDarkMode;
    Get.changeThemeMode(
      MainController.to.isDarkMode ? ThemeMode.dark : ThemeMode.light,
    );
  }

  Future<void> getCampaignGroupMap() async {
    final List<CampaignData> campaignListData;
    try {
      campaignListData = await campaignsTable.getCampaignListData();

      for (CampaignData campaignData in campaignListData) {
        if (campaignGroupMap.containsKey(campaignData)) {
          continue;
        }

        if (campaignData.campaignKey == null ||
            campaignData.campaignKey == '') {
          continue;
        }

        final List<GroupData> groupData =
            await groupsTable.getGroupListData(campaignData.campaignKey!);
        campaignGroupMap[campaignData] = groupData;
      }
    } catch (e) {
      rethrow;
    }
  }
}
