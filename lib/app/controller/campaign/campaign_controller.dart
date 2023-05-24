import 'package:get/get.dart';

import '/app/data/model/campaign/campaign_data.dart';

import '/app/storage/campaign/campaign_list_data_storage.dart';

class CampaignController extends GetxController {
  // Campaign List Data
  RxList<CampaignData> campaignListData = <CampaignData>[].obs;

  @override
  void onInit() async {
    await getCampaignListData();

    super.onInit();
  }

  Future<void> getCampaignListData() async {
    try {
      campaignListData.value = campaignListDataStorage.campaignListData;
    } catch (e) {
      rethrow;
    }
  }
}
