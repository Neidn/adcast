import 'package:adcast/app/controller/group/group_controller.dart';
import 'package:adcast/app/data/model/user/user_api_data.dart';
import 'package:adcast/app/storage/db/user_api_table.dart';
import 'package:get/get.dart';

import '/app/utils/global_variables.dart';


import '/app/storage/db/keywords_table.dart';
import '/app/storage/db/user_info_table.dart';
import '/app/storage/db/campaigns_table.dart';
import '/app/storage/db/groups_table.dart';
import '/app/data/model/campaign/group_data.dart';
import '/app/data/model/campaign/campaign_data.dart';

class CampaignController extends GetxController {
  static CampaignController get to => Get.find();

  // Database Table
  UserInfoTable userInfoTable = UserInfoTable(appUserInfoTable);
  UserApiTable userApiTable = UserApiTable(appUserApiTable);
  GroupsTable groupsTable = GroupsTable(appGroupsTable);
  KeywordsTable keywordsTable = KeywordsTable(appKeywordsTable);
  CampaignsTable campaignsTable = CampaignsTable(appCampaignsTable);

  // UserApi.customerId CampaignKey Map
  final RxMap<String, List<CampaignData>> _userApiCampaignMap =
      <String, List<CampaignData>>{}.obs;

  Map<String, List<CampaignData>> get userApiCampaignMap => _userApiCampaignMap;

  set userApiCampaignMap(value) => _userApiCampaignMap.value = value;

  // UserApiList
  final RxList<UserApiData> _userApiList = <UserApiData>[].obs;

  List get userApiList => _userApiList;

  set userApiList(value) => _userApiList.value = value;

  // loading
  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set isLoading(bool value) => _isLoading.value = value;

  @override
  void onInit() async {
    super.onInit();
    await getUserApiMap();
    await getCampaignGroupMap();
    isLoading = false;
  }

  Future<void> getUserApiMap() async {
    userApiList = await userApiTable.getUserApiListData();
  }

  Future<void> getCampaignGroupMap() async {
    final List<CampaignData> campaignListData;
    try {
      campaignListData = await campaignsTable.getCampaignListData();

      final campaignGroupMap = <CampaignData, List<GroupData>>{};

      // Campaign Group Map
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

      GroupController.to.campaignGroupMap = campaignGroupMap;

      // UserApi.customerId CampaignKey Map
      for (UserApiData userApiData in userApiList) {
        if (userApiData.customerId == null || userApiData.customerId == '') {
          continue;
        }

        final List<CampaignData> campaignList = campaignListData
            .where((element) => element.customerId == userApiData.customerId)
            .toList();

        userApiCampaignMap[userApiData.customerId!] = campaignList;
      }
    } catch (e) {
      rethrow;
    }
  }
}
