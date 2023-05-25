import 'package:get/get.dart';

import '/app/data/repository/ad_keyword_impl.dart';

import '/app/controller/keyword/keyword_controller.dart';

import '/app/storage/db/user_info_table.dart';
import '/app/storage/db/groups_table.dart';
import '/app/storage/db/keyword_info_table.dart';
import '/app/storage/db/keywords_table.dart';

import '/app/data/model/campaign/group_data.dart';

import '/app/data/model/api/api_ad_keyword_response.dart';
import '/app/data/model/api/api_ad_keyword_result.dart';

import '/app/data/model/keyword/keyword_data.dart';
import '/app/data/model/keyword/keyword_info_data.dart';
import '/app/data/model/keyword/keyword_list_info_data.dart';

import '/app/services/auth_service.dart';

import '/app/utils/global_variables.dart';

class GroupController extends GetxController {
  static GroupController get to => Get.find();

  // Database Table
  UserInfoTable userInfoTable = UserInfoTable(appUserInfoTable);
  GroupsTable groupsTable = GroupsTable(appGroupsTable);
  KeywordInfoTable keywordInfoTable = KeywordInfoTable(appKeywordInfoTable);
  KeywordsTable keywordsTable = KeywordsTable(appKeywordsTable);

  // Group List Data
  final RxList<GroupData> _groupListData = <GroupData>[].obs;

  List<GroupData> get groupListData => _groupListData;

  set groupListData(List<GroupData> value) => _groupListData.value = value;

  // Customer Key
  final RxString _customerKey = ''.obs;

  String get customerKey => _customerKey.value;

  set customerKey(String value) => _customerKey.value = value;

  @override
  void onInit() async {
    // Customer Key
    customerKey = await userInfoTable.getCustomerKey();
    super.onInit();
  }

  void resetGroupListData() => groupListData = [];

  // loading
  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set isLoading(bool value) => _isLoading.value = value;

  Future<void> getGroupListData(String campaignKey) async {
    try {
      resetGroupListData();
      groupListData = await groupsTable.getGroupNewListData(campaignKey);
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
      KeywordController.to.resetKeywordListData();
      await keywordsTable.deleteAll();

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
        campaignKey: camId,
        groupKey: grId,
        totalData: response.totalData ?? '0',
        totalPage: apiAdKeywordResult.totalPage ?? '0',
        pageSize: pageSize,
        currentPage: page,
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

      // Success
      Get.snackbar(
        'Data Fetching is success',
        'Data is successfully fetched from the server.',
        snackPosition: SnackPosition.TOP,
      );
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
