import 'package:get/get.dart';

import '/app/utils/global_variables.dart';

import '/app/data/repository/ad_keyword_impl.dart';

import '/app/storage/device/device_token_storage.dart';

import '/app/storage/db/keywords_table.dart';
import '/app/storage/db/user_info_table.dart';
import '/app/storage/db/keyword_info_table.dart';
import '/app/storage/db/campaigns_table.dart';
import '/app/storage/db/groups_table.dart';

import '/app/controller/keyword/keyword_controller.dart';

import '/app/data/model/api/api_ad_keyword_response.dart';
import '/app/data/model/api/api_ad_keyword_result.dart';
import '/app/data/model/keyword/keyword_data.dart';
import '/app/data/model/keyword/keyword_info_data.dart';
import '/app/data/model/keyword/keyword_list_info_data.dart';
import '/app/data/model/campaign/group_data.dart';
import '/app/data/model/campaign/campaign_data.dart';

class CampaignController extends GetxController {
  static CampaignController get to => Get.find();

  // Database Table
  UserInfoTable userInfoTable = UserInfoTable(appUserInfoTable);
  GroupsTable groupsTable = GroupsTable(appGroupsTable);
  KeywordInfoTable keywordInfoTable = KeywordInfoTable(appKeywordInfoTable);
  KeywordsTable keywordsTable = KeywordsTable(appKeywordsTable);
  CampaignsTable campaignsTable = CampaignsTable(appCampaignsTable);

  // Campaign Group Map
  final RxMap<CampaignData, List<GroupData>> _campaignGroupMap =
      <CampaignData, List<GroupData>>{}.obs;

  Map<CampaignData, List<GroupData>> get campaignGroupMap => _campaignGroupMap;

  set campaignGroupMap(value) => _campaignGroupMap.value = value;

  // loading
  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set isLoading(bool value) => _isLoading.value = value;

  @override
  void onInit() async {
    super.onInit();
    await getCampaignGroupMap();
    isLoading = false;
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

  Future<void> getKeyword(
    String campaignKey,
    String groupKey,
  ) async {
    isLoading = true;
    AdKeywordImpl adKeywordImpl = AdKeywordImpl();

    try {
      KeywordController.to.resetKeywordListData();
      await keywordsTable.deleteAll();

      String cid = await userInfoTable.getCustomerKey();

      ApiAdKeywordResponse response = await adKeywordImpl.getKeyword(
        deviceTokenStorage.deviceToken,
        cid,
        campaignKey,
        groupKey,
        defaultPageSizeString,
        defaultPageString,
      );

      ApiAdKeywordResult apiAdKeywordResult =
          ApiAdKeywordResult.fromJson(response.data!);

      if (apiAdKeywordResult.apiResultEmptyCheck() == true) {
        throw Exception('Data is Null');
      }

      // Keyword Info Data
      KeywordInfoData keywordInfoData = KeywordInfoData(
        campaignKey: campaignKey,
        groupKey: groupKey,
        totalData: response.totalData ?? '0',
        totalPage: apiAdKeywordResult.totalPage ?? '0',
        pageSize: defaultPageSizeString,
        currentPage: defaultPageString,
      );

      int result = await keywordInfoTable.keywordInfoInsert(keywordInfoData);

      if (result == 0) {
        throw Exception('Try Again');
      }

      // Parsing Keyword List Data
      KeywordListInfoData keywordListInfoData =
          KeywordListInfoData.fromJson(apiAdKeywordResult.keyword!);

      if (keywordListInfoData.emptyKeywordListDataCheck() == true) {
        throw Exception('Data is Null here');
      }

      // Keyword List data
      List<KeywordData> keywordNewDataList = <KeywordData>[];

      for (var data in keywordListInfoData.data!.entries) {
        data.value['keyword_key'] = data.key;

        KeywordData keywordData = KeywordData.fromJson(data.value);

        if (keywordData.keywordDataEmptyCheck() == true) {
          throw Exception('Data is Null Here');
        }

        keywordNewDataList.add(keywordData);
      }

      await keywordsTable.keywordsInsert(keywordNewDataList);

      // keyword controller data set
      KeywordController.to.getKeywordListData();
    } catch (e) {
      await keywordInfoTable.deleteAll();
      await keywordsTable.deleteAll();

      Get.snackbar(
        'Data Fetching is failed',
        // 'Data is failed to fetch from the server.',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading = false;
    }
  }
}
