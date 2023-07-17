import 'package:adcast/app/ui/default/campaign/page/campaign_page.dart';
import 'package:adcast/app/ui/default/payment/page/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/middle_ware/auth_middle_ware.dart';

// Pages Start
import '/app/bindings/main_binding.dart';
import '/app/ui/default/main/page/main_page.dart';

import '/app/bindings/login_binding.dart';
import '/app/ui/default/auth/page/login_page.dart';

import '../ui/default/profile/page/profile_page.dart';

import '/app/ui/default/keyword/page/keyword_page.dart';
// Pages End

part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
      middlewares: [
        AuthMiddleWare(),
      ],
    ),
    GetPage(
      name: Routes.main,
      page: () => const MainPage(),
      binding: MainBinding(),
      middlewares: [
        AuthMiddleWare(),
      ],
    ),
  ];

  static final List<Map<String, dynamic>> navigationScreensProperties = [
    {
      "route": Routes.campaign,
      // "page": const CampaignPage(),
      "page": const CampaignPage(),
      "title": "캠페인",
      "active_icon": Icons.home,
      "inactive_icon": Icons.home_outlined,
    },
    // {
    //   "route": Routes.group,
    //   "page": const GroupPage(),
    //   "title": "그룹",
    //   "active_icon": Icons.home,
    //   "inactive_icon": Icons.home_outlined,
    // },
    {
      "route": Routes.keyword,
      "page": const KeywordPage(),
      "title": "키워드",
      "active_icon": Icons.person,
      "inactive_icon": Icons.person_outline,
    },
    {
      "route": Routes.payment,
      "page": const PaymentPage(),
      "title": "결제",
      "active_icon": Icons.check_box,
      "inactive_icon": Icons.check_box_outlined,
    },
    {
      "route": Routes.profile,
      "page": const ProfilePage(),
      "title": "프로필",
      "active_icon": Icons.settings,
      "inactive_icon": Icons.settings_outlined,
    },
  ];
}
