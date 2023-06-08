import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/ui/theme/app_colors.dart';

import '/app/routes/app_pages.dart';

import '/app/ui/default/widgets/default_logo_widget.dart';
import '/app/ui/default/campaign/widget/group_name_widget.dart';

import '/app/data/model/campaign/campaign_data.dart';
import '/app/data/model/campaign/group_data.dart';

import '/app/controller/main/main_controller.dart';
import '/app/controller/campaign/campaign_controller.dart';

class CampaignPage extends GetView<CampaignController> {
  const CampaignPage({Key? key}) : super(key: key);

  void loadKeywordData(
    String campaignKey,
    String groupKey,
  ) async {
    await controller.getKeyword(
      campaignKey,
      groupKey,
    );

    final int index = AppPages.navigationScreensProperties.indexWhere(
      (element) => element["route"] == Routes.keyword,
    );

    MainController.to.animateToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const DefaultLogoWidget(),
        centerTitle: false,
        backgroundColor: MainController.to.isDarkMode
            ? mobileDarkBackGroundColor
            : mobileLightBackGroundColor,
      ),
      body: GetX<CampaignController>(
        builder: (_) {
          // print all of the campaign data
          return Column(
            children: [
              // loading indicator
              _.isLoading
                  ? const LinearProgressIndicator()
                  : const Padding(padding: EdgeInsets.only(top: 0)),

              // Divider
              const Divider(),

              // Campaign List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 8),
                  scrollDirection: Axis.vertical,
                  itemCount: _.campaignGroupMap.length,
                  itemBuilder: (context, index) {
                    final CampaignData campaignData =
                        _.campaignGroupMap.keys.elementAt(index);
                    final List<GroupData> groupData =
                        _.campaignGroupMap.values.elementAt(index);

                    final String campaignName =
                        campaignData.campaignName as String;
                    final String campaignKey =
                        campaignData.campaignKey as String;

                    final bool campaignLock =
                        campaignData.userLock == "ON" ? true : false;
                    final String campaignStatusReason =
                        campaignData.statusReason as String; // 잠금 사유

                    return ExpansionTile(
                      title: RichText(
                        text: TextSpan(
                          text: campaignName,
                          style: Get.textTheme.displayMedium,
                          children: [
                            const TextSpan(text: " "),
                            TextSpan(
                              text:
                                  campaignLock ? "($campaignStatusReason)" : "",
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      subtitle: Text(
                        "광고 그룹 : ${groupData.length} 개",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),

                      // Campaign List
                      children: List.generate(
                        groupData.length,
                        (index) {
                          final String groupKey =
                              groupData[index].groupKey as String;
                          final String groupName =
                              groupData[index].groupName as String;
                          final bool groupLock =
                              groupData[index].userLock == "ON" ? true : false;
                          final String groupStatusReason =
                              groupData[index].statusReason as String; // 잠금 사유

                          return SizedBox(
                            child: InkWell(
                              onTap: () {
                                if (!groupLock) {
                                  loadKeywordData(
                                    campaignKey,
                                    groupKey,
                                  );
                                }
                              },
                              child: GroupNameWidget(
                                groupLock,
                                groupName,
                                groupStatusReason,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
