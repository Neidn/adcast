import 'package:get/get.dart';

import '/app/data/repository/ad_keyword_impl.dart';

import '/app/controller/keyword/keyword_controller.dart';

import '/app/storage/campaign/group_list_data_storage.dart';
import '/app/storage/keyword/keyword_list_data_storage.dart';
import '/app/storage/keyword/keyword_info_storage.dart';

import '/app/data/model/campaign/group_data.dart';

import '/app/data/model/api/api_ad_keyword_response.dart';
import '/app/data/model/api/api_ad_keyword_result.dart';

import '/app/data/model/keyword/keyword_data.dart';
import '/app/data/model/keyword/keyword_list_data.dart';
import '/app/data/model/keyword/keyword_info_data.dart';

class GroupController extends GetxController {
  // Group List Data
  RxList<GroupData> groupListData = <GroupData>[].obs;

  set setGroupListData(List<GroupData> value) => groupListData.value = value;

  void resetGroupListData() {
    setGroupListData = [];
  }

  // loading
  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set isLoading(bool value) => _isLoading.value = value;

  Future<void> getGroupListData(String campaignKey) async {
    try {
      resetGroupListData();
      await Get.find<KeywordController>().resetKeywordListData();
      setGroupListData = groupListDataStorage.getGroupListData(campaignKey);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getKeyword(
    String deviceToken,
    String cid,
    String camId,
    String grId,
    String pageSize,
    String page,
  ) async {
    isLoading = true;
    AdKeywordImpl adKeywordImpl = AdKeywordImpl();

    try {
      await Get.find<KeywordController>().resetKeywordListData();

      ApiAdKeywordResponse response = await adKeywordImpl.getKeyword(
        deviceToken,
        cid,
        camId,
        grId,
        pageSize,
        page,
      );

      ApiAdKeywordResult apiAdKeywordResult =
          ApiAdKeywordResult.fromJson(response.data!);

      if (apiAdKeywordResult.apiResultEmptyCheck() == true) {
        throw Exception('Data is Null');
      }

      // Keyword Info Data
      KeywordInfoData keywordInfoData = KeywordInfoData(
        userId: response.userId,
        customerId: response.customerId,
        campaignId: response.campaignId,
        groupId: response.groupId,
        totalData: response.totalData,
        totalPage: apiAdKeywordResult.totalPage,
        pageSize: pageSize,
        page: apiAdKeywordResult.page,
      );

      if (keywordInfoData.apiResultEmptyCheck() == true) {
        throw Exception('Data is Null');
      }

      // Keyword Info Storage
      keywordInfoStorage.setKeywordInfoData = keywordInfoData;

      if (keywordInfoStorage.emptyKeywordInfoDataCheck() == true) {
        throw Exception('Data is Null');
      }

      // Parsing Keyword List Data
      KeywordListData keywordListData =
          KeywordListData.fromJson(apiAdKeywordResult.keyword!);

      if (keywordListData.emptyKeywordListDataCheck() == true) {
        throw Exception('Data is Null here');
      }

      // Keyword List Data
      List<KeywordData> keywordDataList = <KeywordData>[];

      for (var data in keywordListData.data!.entries) {
        data.value['keyword_key'] = data.key;
        KeywordData keywordData = KeywordData.fromJson(data.value);

        if (keywordData.keywordDataEmptyCheck() == true) {
          throw Exception('Data is Null');
        }

        keywordDataList.add(keywordData);
      }

      // Keyword List Data Storage
      keywordListDataStorage.setKeywordListData = keywordDataList;

      if (keywordListDataStorage.emptyKeywordListDataCheck() == true) {
        throw Exception('Data is Null');
      }

      // keyword controller data set
      Get.find<KeywordController>().getKeywordListData();

      // Success
      Get.snackbar(
        'Data Fetching is success',
        'Data is successfully fetched from the server.',
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      keywordInfoStorage.resetKeywordInfo();
      keywordListDataStorage.resetKeywordListData();

      Get.snackbar(
        'Data Fetching is failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading = false;
    }
  }
}
