import 'package:get/get.dart';

import '/app/utils/global_variables.dart';

import '/app/storage/db/campaigns_table.dart';
import '/app/data/model/campaign/campaign_data.dart';

class CampaignController extends GetxController {
  // Campaign List Data
  final RxList<CampaignData> _campaignListData = <CampaignData>[].obs;

  List<CampaignData> get campaignListData => _campaignListData;

  set campaignListData(value) => _campaignListData.value = value;

  CampaignsTable campaignsTable = CampaignsTable(appCampaignsTable);

  @override
  void onInit() async {
    await getCampaignListData();

    super.onInit();
  }

  Future<void> getCampaignListData() async {
    try {
      campaignListData = await campaignsTable.getCampaignListData();
    } catch (e) {
      rethrow;
    }
  }
}
