import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/utils/global_variables.dart';

import '/app/data/model/campaign/group_data.dart';

import '/app/storage/device/device_token_storage.dart';

import '/app/controller/main/main_controller.dart';
import '/app/controller/group/group_controller.dart';

import '/app/routes/app_pages.dart';

class GroupPage extends GetView<GroupController> {
  const GroupPage({Key? key}) : super(key: key);

  void loadKeywordListData(
    String deviceToken,
    String cid,
    String camId,
    String grId,
    String pageSize,
    String page,
  ) async {
    await controller.getKeyword(deviceToken, cid, camId, grId, pageSize, page);

    // Change bottom navigation bar index to ad group page
    final int index = AppPages.navigationScreensProperties.indexWhere(
      (element) => element["route"] == Routes.keyword,
    );

    Get.find<MainController>().changePage(index);
  }

  @override
  Widget build(BuildContext context) {
    return GetX<GroupController>(
      builder: (_) {
        if (_.groupListData.isEmpty) {
          return const Center(
            child: Text(
              'No Data',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        // print all of the group data
        return ListView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          scrollDirection: Axis.vertical,
          itemCount: _.groupListData.length,
          itemBuilder: (context, index) {
            final GroupData groupData = _.groupListData[index];
            final String groupDataName = groupData.groupName as String;

            final String deviceToken = deviceTokenStorage.deviceToken;
            final String cid = _.customerKey;
            final String camId = groupData.campaignKey as String;
            final String grId = groupData.groupKey as String;

            return InkWell(
              onTap: () => loadKeywordListData(
                deviceToken,
                cid,
                camId,
                grId,
                defaultPageSizeString,
                defaultPageString,
              ),
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
                      groupDataName,
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
