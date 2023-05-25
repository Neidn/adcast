import 'package:adcast/app/controller/keyword/keyword_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '/app/routes/app_pages.dart';

import '/app/controller/main/main_controller.dart';

class MainPage extends GetView<MainController> {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final int keywordIndex = AppPages.navigationScreensProperties.indexWhere(
      (element) => element["route"] == Routes.keyword,
    );

    return GetX<MainController>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(
            AppPages.navigationScreensProperties[_.currentIndex]['title'],
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: PageView(
            controller: _.pageController,
            onPageChanged: _.animateToPage,
            physics: const NeverScrollableScrollPhysics(),
            children: _.pages,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _.currentIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Get.theme.colorScheme.primary,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white24,
          type: BottomNavigationBarType.fixed,
          onTap: _.changePage,
          items: List.generate(
            AppPages.navigationScreensProperties.length,
            (index) => BottomNavigationBarItem(
              activeIcon: Icon(
                  AppPages.navigationScreensProperties[index]['active_icon']),
              icon: Icon(
                  AppPages.navigationScreensProperties[index]['inactive_icon']),
              label: AppPages.navigationScreensProperties[index]['title'],
            ),
          ),
        ),
      ),
    );
  }
}
