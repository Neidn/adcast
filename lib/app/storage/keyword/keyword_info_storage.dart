import 'package:get_storage/get_storage.dart';

import '/app/utils/global_variables.dart';

import '/app/data/model/keyword/keyword_info_data.dart';

class KeywordInfoStorage {
  final _box = GetStorage(appStorage);

  // Keyword Info Data
  KeywordInfoData get keywordInfoData =>
      KeywordInfoData.fromJson(_box.read(keywordInfoDataStorageKey) ?? {});

  set setKeywordInfoData(KeywordInfoData value) =>
      _box.write(keywordInfoDataStorageKey, value.toJson());

  void refreshKeywordInfoData(KeywordInfoData value) {
    _box.remove(keywordInfoDataStorageKey);
    setKeywordInfoData = value;
  }

  Future<void> resetKeywordInfo() async {
    try {
      await _box.remove(keywordInfoDataStorageKey);
    } catch (e) {
      rethrow;
    }
  }

  bool emptyKeywordInfoDataCheck() {
    try {
      if (keywordInfoData.userId == null ||
          keywordInfoData.userId == "" ||
          keywordInfoData.customerId == null ||
          keywordInfoData.customerId == "" ||
          keywordInfoData.campaignId == null ||
          keywordInfoData.campaignId == "" ||
          keywordInfoData.groupId == null ||
          keywordInfoData.groupId == "" ||
          keywordInfoData.totalData == null ||
          keywordInfoData.totalPage == null ||
          keywordInfoData.pageSize == null ||
          keywordInfoData.page == null) {
        return true;
      }

      int? totalDataInt = int.tryParse(keywordInfoData.totalData!);
      int? totalPageInt = int.tryParse(keywordInfoData.totalPage!);
      int? pageSizeInt = int.tryParse(keywordInfoData.pageSize!);
      int? pageInt = int.tryParse(keywordInfoData.page!);

      if (totalDataInt == null ||
          totalDataInt < 0 ||
          totalPageInt == null ||
          totalPageInt < 0 ||
          pageSizeInt == null ||
          pageSizeInt < 0 ||
          pageInt == null ||
          pageInt < 0) {
        return true;
      }
    } catch (e) {
      resetKeywordInfo();
      return true;
    }
    return false;
  }
}

final keywordInfoStorage = KeywordInfoStorage();
