import 'package:adcast/app/controller/group/group_controller.dart';
import 'package:adcast/app/controller/payment/payment_controller.dart';
import 'package:get/get.dart';

import '/app/controller/main/main_controller.dart';

import '/app/controller/campaign/campaign_controller.dart';

import '/app/controller/keyword/keyword_controller.dart';

import '/app/controller/profile/profile_controller.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    // give dependency to navigation bar widget
    Get.put(MainController());

    // give dependency
    Get.put(CampaignController());
    Get.put(GroupController());
    Get.put(KeywordController());
    Get.put(ProfileController());
    Get.put(PaymentController());
  }
}
