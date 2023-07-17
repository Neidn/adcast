import 'package:adcast/app/controller/group/group_controller.dart';
import 'package:adcast/app/controller/keyword/keyword_controller.dart';
import 'package:adcast/app/controller/main/main_controller.dart';
import 'package:adcast/app/data/model/campaign/campaign_data.dart';
import 'package:adcast/app/data/model/campaign/group_data.dart';
import 'package:adcast/app/routes/app_pages.dart';
import 'package:adcast/app/ui/default/campaign/widget/group_name_widget.dart';
import 'package:adcast/app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupPage extends GetView<GroupController> {
  final CampaignData campaignData;

  const GroupPage({
    super.key,
    required this.campaignData,
  });

  void loadKeywordData({
    required String customerId,
    required String campaignKey,
    required String groupKey,
  }) async {
    if (customerId.isEmpty || campaignKey.isEmpty || groupKey.isEmpty) {
      return;
    }

    await controller.getKeyword(
      customerId: customerId,
      campaignKey: campaignKey,
      groupKey: groupKey,
    );

    final int index = AppPages.navigationScreensProperties.indexWhere(
      (element) => element["route"] == Routes.keyword,
    );

    KeywordController.to.customerId = customerId;

    Get.back();
    MainController.to.animateToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          campaignData.campaignName ?? '',
          style: Get.textTheme.headlineMedium,
        ),
        centerTitle: false,
        backgroundColor: MainController.to.isDarkMode
            ? mobileDarkBackGroundColor
            : mobileLightBackGroundColor,
      ),
      body: GetX<GroupController>(
        builder: (_) {
          // print all of the campaign data
          final List<GroupData> groupDataList =
              _.campaignGroupMap[campaignData] ?? <GroupData>[];

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
                  itemCount: groupDataList.length,
                  itemBuilder: (context, index) {
                    final GroupData groupData = groupDataList[index];

                    final bool groupLock = groupData.userLock == "ON";
                    final String groupName = groupData.groupName ?? '';
                    final String groupStatusReason =
                        groupData.statusReason ?? '';

                    return InkWell(
                      onTap: () async {
                        if (groupLock) {
                          return;
                        }
                        loadKeywordData(
                          customerId: campaignData.customerId ?? '',
                          campaignKey: campaignData.campaignKey ?? '',
                          groupKey: groupData.groupKey ?? '',
                        );
                      },
                      child: GroupNameWidget(
                        groupLock: groupLock,
                        groupName: groupName,
                        groupStatusReason: groupStatusReason,
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
