import 'package:adcast/app/ui/theme/app_colors.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '/app/routes/app_pages.dart';

import '/app/controller/main/main_controller.dart';

class MainPage extends GetView<MainController> {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<MainController>(
      builder: (_) => Scaffold(
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
          selectedItemColor: _.isDarkMode
              ? whiteColor
              : blackColor,
          unselectedItemColor: _.isDarkMode
              ? liteWhiteColor
              : liteBlackColor,
          backgroundColor: _.isDarkMode
              ? mobileDarkBackGroundColor
              : mobileLightBackGroundColor,
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
