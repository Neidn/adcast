import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/data/repository/ad_keyword_impl.dart';

import '/app/data/model/api/api_ad_keyword_response.dart';
import '/app/data/model/api/api_ad_keyword_result.dart';
import '/app/data/model/keyword/keyword_data.dart';
import '/app/data/model/keyword/keyword_list_data.dart';
import '/app/data/model/keyword/keyword_info_data.dart';

import '/app/storage/device/device_token_storage.dart';
import '/app/storage/keyword/keyword_info_storage.dart';
import '/app/storage/keyword/keyword_list_data_storage.dart';

class KeywordController extends GetxController {
  // Scroll Controller
  final ScrollController _scrollController = ScrollController();

  ScrollController get scrollController => _scrollController;

  // Keyword List Data
  final RxList<KeywordData> keywordListData = <KeywordData>[].obs;

  set setKeywordListData(List<KeywordData> value) =>
      keywordListData.value = value;

  // loading
  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set isLoading(bool value) => _isLoading.value = value;

  // next loading
  final RxBool _isNextLoading = false.obs;

  bool get isNextLoading => _isNextLoading.value;

  set isNextLoading(bool value) => _isNextLoading.value = value;

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
  void onInit() {
    getKeywordListData();
    scrollController.addListener(_nextKeywordListData);
    super.onInit();
  }

  @override
  void dispose() {
    resetKeywordListData();
    scrollController.removeListener(_nextKeywordListData);
    super.dispose();
  }

  Future<void> resetKeywordListData() async {
    setKeywordListData = [];
  }

  Future<void> getKeywordListData() async {
    isLoading = true;

    try {
      resetKeywordListData();
      setKeywordListData = keywordListDataStorage.keywordListData;
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
    }
  }

  String nextPage() {
    String page = keywordInfoStorage.keywordInfoData.page as String;

    int nextPage = int.parse(page) + 1;

    return nextPage.toString();
  }

  Future<void> _nextKeywordListData() async {
    checkRequest();

    if (isRequest == false) {
      return;
    }

    isNextLoading = true;
    AdKeywordImpl adKeywordImpl = AdKeywordImpl();

    String deviceToken = deviceTokenStorage.deviceToken;
    String cid = keywordInfoStorage.keywordInfoData.customerId as String;
    String camId = keywordInfoStorage.keywordInfoData.campaignId as String;
    String grId = keywordInfoStorage.keywordInfoData.groupId as String;
    String pageSize = keywordInfoStorage.keywordInfoData.pageSize as String;
    String page = nextPage();

    try {
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

      // Next Keyword List Data
      List<KeywordData> nextKeywordDataList = <KeywordData>[];

      if (keywordListData.data!.isNotEmpty) {
        for (var data in keywordListData.data!.entries) {
          data.value['keyword_key'] = data.key;

          if (keywordListDataStorage.keywordListDataContains(data.key) ==
              true) {
            continue;
          }

          KeywordData keywordData = KeywordData.fromJson(data.value);

          if (keywordData.keywordDataEmptyCheck() == true) {
            throw Exception('Data is Null');
          }

          nextKeywordDataList.add(keywordData);
        }

        // Keyword List Data
        List<KeywordData> keywordDataList =
            keywordListDataStorage.keywordListData;

        keywordDataList.addAll(nextKeywordDataList);

        // Set Keyword List Data
        setKeywordListData = keywordDataList;

        // Keyword List Data Storage
        keywordListDataStorage.setKeywordListData = keywordDataList;

        if (keywordListDataStorage.emptyKeywordListDataCheck() == true) {
          throw Exception('Data is Null');
        }
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
