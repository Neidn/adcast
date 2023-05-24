import 'package:get/get.dart';

import '/app/controller/main/main_controller.dart';

import '/app/controller/campaign/campaign_controller.dart';

import '/app/controller/group/group_controller.dart';

import '/app/controller/keyword/keyword_controller.dart';

import '/app/controller/device/device_token_controller.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    // give dependency to navigation bar widget
    Get.put(MainController());

    // give dependency
    Get.put(GroupController());
    Get.put(CampaignController());
    Get.put(KeywordController());
    Get.put(DeviceTokenController());
  }
}
