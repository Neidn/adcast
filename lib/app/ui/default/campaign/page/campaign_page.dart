import 'package:adcast/app/data/model/user/user_api_data.dart';
import 'package:adcast/app/ui/default/campaign/widget/campaign_name_widget.dart';
import 'package:adcast/app/ui/default/group/page/group_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/ui/theme/app_colors.dart';

import '/app/ui/default/widgets/default_logo_widget.dart';

import '/app/data/model/campaign/campaign_data.dart';

import '/app/controller/main/main_controller.dart';
import '/app/controller/campaign/campaign_controller.dart';

class CampaignPage extends GetView<CampaignController> {
  const CampaignPage({super.key});

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
                  itemCount: _.userApiList.length,
                  itemBuilder: (context, index) {
                    final UserApiData userApiData = _.userApiList[index];

                    final List<CampaignData> campaignDataList =
                        _.userApiCampaignMap[userApiData.customerId] ?? [];

                    return ExpansionTile(
                      title: RichText(
                        text: TextSpan(
                          text: userApiData.customerName,
                          style: Get.textTheme.displayMedium,
                        ),
                      ),
                      subtitle: Text(
                        "광고 그룹 : ${_.userApiCampaignMap[userApiData.customerId]?.length} 개",
                        style: Get.textTheme.titleSmall,
                      ),
                      children: campaignDataList.isEmpty
                          ? [
                              SizedBox(
                                height: 100,
                                child: Center(
                                  child: Text(
                                    "광고 그룹이 없습니다.",
                                    style: Get.textTheme.titleMedium,
                                  ),
                                ),
                              ),
                            ]
                          : List.generate(
                              campaignDataList.length,
                              (index) {
                                final CampaignData campaignData =
                                    campaignDataList[index];

                                final String campaignName =
                                    campaignData.campaignName as String;
                                final bool campaignLock =
                                    campaignData.userLock == "ON"
                                        ? true
                                        : false;
                                final String campaignStatusReason = campaignData
                                    .statusReason as String; // 잠금 사유

                                return SizedBox(
                                  child: InkWell(
                                    onTap: () async {
                                      if (campaignLock) {
                                        return;
                                      }

                                      Get.to(() => GroupPage(
                                            campaignData: campaignData,
                                          ));
                                    },
                                    child: CampaignNameWidget(
                                      campaignLock: campaignLock,
                                      campaignName: campaignName,
                                      campaignStatusReason:
                                          campaignStatusReason,
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
