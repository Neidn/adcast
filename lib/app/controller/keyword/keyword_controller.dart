import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/data/repository/ad_keyword_impl.dart';

import '/app/utils/global_variables.dart';

import '/app/storage/db/user_info_table.dart';
import '/app/storage/db/keyword_info_table.dart';
import '/app/storage/db/keywords_table.dart';

import '/app/data/model/user/user_info_data.dart';

import '/app/data/model/api/api_ad_keyword_response.dart';
import '/app/data/model/api/api_ad_keyword_result.dart';

import '/app/data/model/keyword/keyword_data.dart';
import '/app/data/model/keyword/keyword_info_data.dart';
import '/app/data/model/keyword/keyword_list_info_data.dart';

import '/app/storage/device/device_token_storage.dart';

class KeywordController extends GetxController {
  static KeywordController get to => Get.find();

  // Database Table
  UserInfoTable userInfoTable = UserInfoTable(appUserInfoTable);
  KeywordInfoTable keywordInfoTable = KeywordInfoTable(appKeywordInfoTable);
  KeywordsTable keywordsTable = KeywordsTable(appKeywordsTable);

  // Scroll Controller
  final ScrollController _scrollController = ScrollController();

  ScrollController get scrollController => _scrollController;

  // Keyword List Data
  final RxList<KeywordData> _keywordListData = <KeywordData>[].obs;

  List<KeywordData> get keywordListData => _keywordListData;

  set keywordListData(List<KeywordData> value) =>
      _keywordListData.value = value;

  // Keyword Info Data
  final Rx<KeywordInfoData> _keywordInfoData = KeywordInfoData().obs;

  KeywordInfoData get keywordInfoData => _keywordInfoData.value;

  set keywordInfoData(KeywordInfoData value) => _keywordInfoData.value = value;

  // User Info Data
  final Rx<UserInfoData> _userInfoData = UserInfoData().obs;

  UserInfoData get userInfoData => _userInfoData.value;

  set userInfoData(UserInfoData value) => _userInfoData.value = value;

  // loading
  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set isLoading(bool value) => _isLoading.value = value;

  // next loading
  final RxBool _isNextLoading = false.obs;

  bool get isNextLoading => _isNextLoading.value;

  set isNextLoading(bool value) => _isNextLoading.value = value;

  // Bid Exception Filter - default: true
  final RxBool _isBidExceptionFilter = true.obs;

  bool get isBidExceptionFilter => _isBidExceptionFilter.value;

  set isBidExceptionFilter(bool value) => _isBidExceptionFilter.value = value;

  // prevent multiple requests
  final RxDouble _maxScrollExtent = 0.0.obs;
  final RxDouble _currentScrollPosition = 0.0.obs;
  final RxBool _isRequest = false.obs;

  double get maxScrollExtent => _maxScrollExtent.value;

  double get currentScrollPosition => _currentScrollPosition.value;

  bool get isRequest => _isRequest.value;

  set isRequest(bool value) => _isRequest.value = value;

  void setMaxScrollExtent() =>
      _maxScrollExtent.value = scrollController.position.maxScrollExtent;

  void setCurrentScrollPosition() =>
      _currentScrollPosition.value = scrollController.position.pixels;

  // prevent multiple requests
  void checkRequest() {
    setMaxScrollExtent();
    setCurrentScrollPosition();

    if (maxScrollExtent == currentScrollPosition) {
      isRequest = true;
    } else {
      isRequest = false;
    }
  }

  @override
  void onInit() async {
    await getKeywordInfoData();
    await getUserInfoData();
    await getKeywordListData();
    scrollController.addListener(_nextKeywordListData);
    super.onInit();
  }

  @override
  void dispose() {
    resetKeywordListData();
    scrollController.removeListener(_nextKeywordListData);
    super.dispose();
  }

  void resetKeywordListData() => keywordListData = [];

  void changeBidExceptionFilter() async {
    isBidExceptionFilter = !isBidExceptionFilter;
    await getKeywordListData();
  }

  Future<void> getKeywordInfoData() async {
    keywordInfoData = await keywordInfoTable.keywordInfoSelectOne();
  }

  Future<void> getUserInfoData() async {
    userInfoData = await userInfoTable.userInfoSelectOne();
  }

  Future<void> getKeywordListData() async {
    isLoading = true;

    try {
      resetKeywordListData();
      if (isBidExceptionFilter) {
        keywordListData = await keywordsTable.keywordsSelectFilterUserLock();
      } else {
        keywordListData = await keywordsTable.keywordsSelect();
      }
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
    }
  }

  String nextPage() {
    int page = int.tryParse(keywordInfoData.currentPage ?? defaultPageString) ??
        defaultPage;

    int nextPage = page + 1;

    return nextPage.toString();
  }

  Future<void> _nextKeywordListData() async {
    checkRequest();

    if (isRequest == false) {
      return;
    }

    isNextLoading = true;
    AdKeywordImpl adKeywordImpl = AdKeywordImpl();

    try {
      await getKeywordInfoData();
      await getUserInfoData();

      if (keywordInfoData.totalPage == keywordInfoData.currentPage) {
        return;
      }

      String deviceToken = deviceTokenStorage.deviceToken;
      String cid = userInfoData.customerKey ?? '';
      String camId = keywordInfoData.campaignKey ?? '';
      String grId = keywordInfoData.groupKey ?? '';
      String pageSize = keywordInfoData.pageSize ?? defaultPageSizeString;
      String page = nextPage();

      ApiAdKeywordResponse response = await adKeywordImpl.getKeyword(
        deviceToken,
        cid,
        camId,
        grId,
        pageSize,
        page,
      );

      // Keyword Info Data
      ApiAdKeywordResult apiAdKeywordResult =
          ApiAdKeywordResult.fromJson(response.data!);

      if (apiAdKeywordResult.apiResultEmptyCheck() == true) {
        throw Exception('Data is Null');
      }

      // Keyword Info Data
      KeywordInfoData newKeywordInfoData = KeywordInfoData(
        totalData: response.totalData ?? '0',
        totalPage: apiAdKeywordResult.totalPage ?? '0',
        pageSize: pageSize,
        currentPage: apiAdKeywordResult.page ?? '0',
      );

      keywordInfoTable.keywordInfoUpdateOne(
          newKeywordInfoData, keywordInfoData.id);

      // Parsing Keyword List Data
      KeywordListInfoData keywordListInfoData =
          KeywordListInfoData.fromJson(apiAdKeywordResult.keyword!);

      // Next Keyword List Data
      List<KeywordData> nextKeywordDataList = <KeywordData>[];

      if (keywordListInfoData.data!.isNotEmpty) {
        for (var data in keywordListInfoData.data!.entries) {
          data.value['keyword_key'] = data.key;

          // Keyword Exists Check
          bool exists = await keywordsTable.keywordExists(data.key);
          if (exists == true) continue;

          KeywordData keywordData = KeywordData.fromJson(data.value);

          if (keywordData.keywordDataEmptyCheck() == true) {
            throw Exception('Data is Null');
          }

          nextKeywordDataList.add(keywordData);
        }

        // Keyword List Data Save
        await keywordsTable.keywordsInsert(nextKeywordDataList);
        await getKeywordListData();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isNextLoading = false;
    }
  }
}
