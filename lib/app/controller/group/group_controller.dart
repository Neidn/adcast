import 'package:adcast/app/controller/keyword/keyword_controller.dart';
import 'package:adcast/app/data/model/api/api_ad_keyword_response.dart';
import 'package:adcast/app/data/model/api/api_ad_keyword_result.dart';
import 'package:adcast/app/data/model/campaign/campaign_data.dart';
import 'package:adcast/app/data/model/campaign/group_data.dart';
import 'package:adcast/app/data/model/keyword/keyword_data.dart';
import 'package:adcast/app/data/model/keyword/keyword_info_data.dart';
import 'package:adcast/app/data/model/keyword/keyword_list_info_data.dart';
import 'package:adcast/app/data/repository/ad_keyword_impl.dart';
import 'package:adcast/app/storage/db/keyword_info_table.dart';
import 'package:adcast/app/storage/db/keywords_table.dart';
import 'package:adcast/app/storage/device/device_token_storage.dart';
import 'package:adcast/app/utils/global_variables.dart';
import 'package:get/get.dart';

class GroupController extends GetxController {
  static GroupController get to => Get.find();

  // Table
  KeywordInfoTable keywordInfoTable = KeywordInfoTable(appKeywordInfoTable);
  KeywordsTable keywordsTable = KeywordsTable(appKeywordsTable);

  // Campaign Group Map
  final RxMap<CampaignData, List<GroupData>> _campaignGroupMap =
      <CampaignData, List<GroupData>>{}.obs;

  Map<CampaignData, List<GroupData>> get campaignGroupMap => _campaignGroupMap;

  set campaignGroupMap(value) => _campaignGroupMap.value = value;

  // Loading
  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set isLoading(bool value) => _isLoading.value = value;

  Future<void> getKeyword({
    required String customerId,
    required String campaignKey,
    required String groupKey,
  }) async {
    isLoading = true;
    AdKeywordImpl adKeywordImpl = AdKeywordImpl();

    try {
      KeywordController.to.resetKeywordListData();
      await keywordsTable.deleteAll();

      // Title
      await KeywordController.to.getTitleName(
        customerId: customerId,
        campaignKey: campaignKey,
        groupKey: groupKey,
      );

      final String deviceToken = await deviceTokenStorage.getDeviceToken();

      ApiAdKeywordResponse response = await adKeywordImpl.getKeyword(
        deviceToken,
        customerId,
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
