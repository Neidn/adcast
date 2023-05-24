import 'package:get_storage/get_storage.dart';

import '/app/utils/global_variables.dart';

import '/app/data/model/campaign/group_data.dart';

class GroupListDataStorage {
  final _box = GetStorage(appStorage);

  // Group List Data
  List<GroupData> get groupListData {
    try {
      return List<GroupData>.from(_box.read(groupListDataStorageKey) ?? {});
    } catch (e) {
      resetGroupListData();
      return [];
    }
  }

  set groupListData(List<GroupData> value) =>
      _box.write(groupListDataStorageKey, value);

  Future<void> resetGroupListData() async {
    try {
      await _box.remove(groupListDataStorageKey);
    } catch (e) {
      rethrow;
    }
  }

  bool emptyGroupListDataCheck() {
    try {
      if (groupListDataStorage.groupListData.isEmpty) {
        return true;
      }
    } catch (e) {
      resetGroupListData();
      return true;
    }
    return false;
  }

  List<GroupData> getGroupListData(String campaignKey) {
    try {
      return groupListDataStorage.groupListData
          .where((element) => element.campaignKey == campaignKey)
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}

final groupListDataStorage = GroupListDataStorage();
