import 'package:get_storage/get_storage.dart';

import '/app/utils/global_variables.dart';

import '/app/data/model/campaign/campaign_data.dart';

class CampaignListDataStorage {
  final _box = GetStorage(appStorage);

  // Campaign List Data
  List<CampaignData> get campaignListData {
    try {
      return List<CampaignData>.from(
          _box.read(campaignListDataStorageKey) ?? {});
    } catch (e) {
      resetCampaignListData();
      return [];
    }
  }

  set campaignListData(List<CampaignData> value) =>
      _box.write(campaignListDataStorageKey, value);

  Future<void> resetCampaignListData() async {
    try {
      await _box.remove(campaignListDataStorageKey);
    } catch (e) {
      rethrow;
    }
  }

  bool emptyCampaignListDataCheck() {
    try {
      if (campaignListDataStorage.campaignListData.isEmpty) {
        return true;
      }
    } catch (e) {
      resetCampaignListData();
      return true;
    }
    return false;
  }
}

final campaignListDataStorage = CampaignListDataStorage();
