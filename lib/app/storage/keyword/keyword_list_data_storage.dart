import 'package:get_storage/get_storage.dart';

import '/app/utils/global_variables.dart';

import '/app/data/model/keyword/keyword_data.dart';

class KeywordListDataStorage {
  final _box = GetStorage(appStorage);

  // Keyword List Data
  List<KeywordData> get keywordListData {
    try {
      return List<KeywordData>.from(_box.read(keywordListDataStorageKey) ?? {});
    } catch (e) {
      resetKeywordListData();
      return [];
    }
  }

  set setKeywordListData(List<KeywordData> value) =>
      _box.write(keywordListDataStorageKey, value);

  Future<void> resetKeywordListData() async {
    try {
      await _box.remove(keywordListDataStorageKey);
    } catch (e) {
      rethrow;
    }
  }

  bool emptyKeywordListDataCheck() {
    try {
      if (keywordListData.isEmpty) {
        return true;
      }

      for (KeywordData keywordData in keywordListData) {
        if (keywordData.keywordDataEmptyCheck() == true) {
          return true;
        }
      }
    } catch (e) {
      resetKeywordListData();
      return true;
    }

    return false;
  }

  void setNextKeywordListData(List<KeywordData> nextKeywordDataList) async {
    keywordListData.addAll(nextKeywordDataList);

    print('length: ${keywordListData.length}');
  }

  bool keywordListDataContains(String keywordKey) {
    try {
      for (KeywordData keywordData in keywordListData) {
        String keywordDataKeywordKey = keywordData.keywordKey as String;

        if (keywordKey.compareTo(keywordDataKeywordKey) == 0) {
          return true;
        }
      }
    } catch (e) {
      return false;
    }
    return false;
  }
}

final keywordListDataStorage = KeywordListDataStorage();
