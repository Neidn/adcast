import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/middle_ware/auth_middle_ware.dart';

// Pages Start
import '/app/bindings/main_binding.dart';
import '../ui/default/main/page/main_page.dart';

import '/app/bindings/login_binding.dart';
import '/app/ui/default/auth/page/login_page.dart';

import '/app/ui/default/profile/profile_page.dart';

import '/app/ui/default/campaign/page/campaign_page.dart';

import '/app/ui/default/group/group_page.dart';

import '/app/ui/default/keyword/page/keyword_page.dart';
// Pages End

import '/app/ui/default/dummy/second_page.dart';

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
      "page": const CampaignPage(),
      "title": "캠페인",
      "active_icon": Icons.home,
      "inactive_icon": Icons.home_outlined,
    },
    {
      "route": Routes.adGroup,
      "page": const GroupPage(),
      "title": "광고 그룹",
      "active_icon": Icons.favorite,
      "inactive_icon": Icons.favorite_border,
    },
    {
      "route": Routes.keyword,
      "page": const KeywordPage(),
      "title": "키워드",
      "active_icon": Icons.person,
      "inactive_icon": Icons.person_outline,
    },
    {
      "route": Routes.second,
      "page": const SecondPage(),
      "title": "더미",
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
