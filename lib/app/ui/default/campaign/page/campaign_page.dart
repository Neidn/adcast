import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/routes/app_pages.dart';

import '/app/data/model/campaign/campaign_data.dart';

import '/app/controller/main/main_controller.dart';
import '/app/controller/keyword/keyword_controller.dart';
import '/app/controller/campaign/campaign_controller.dart';
import '/app/controller/group/group_controller.dart';

class CampaignPage extends GetView<CampaignController> {
  const CampaignPage({Key? key}) : super(key: key);

  void loadGroupData(String campaignKey) async {
    KeywordController.to.resetKeywordListData();
    GroupController.to.resetGroupListData();
    await GroupController.to.getGroupListData(campaignKey);

    // Change bottom navigation bar index to ad group page
    final int index = AppPages.navigationScreensProperties.indexWhere(
      (element) => element["route"] == Routes.adGroup,
    );

    MainController.to.changePage(index);
  }

  @override
  Widget build(BuildContext context) {
    return GetX<CampaignController>(
      builder: (_) {
        // print all of the campaign data
        return ListView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          scrollDirection: Axis.vertical,
          itemCount: _.campaignListData.length,
          itemBuilder: (context, index) {
            final CampaignData campaignData = _.campaignListData[index];
            final String campaignName = campaignData.campaignName as String;
            final String campaignKey = campaignData.campaignKey as String;

            return InkWell(
              onTap: () => loadGroupData(campaignKey),
              autofocus: true,
              splashColor: Colors.grey,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.campaign,
                      size: 30,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      campaignName,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
