import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/controller/main/main_controller.dart';

import '/app/routes/app_pages.dart';

import '/app/ui/theme/app_theme.dart';

class NavigationBar extends GetView<MainController> {
  const NavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<MainController>(
      builder: (_) {
        return BottomNavigationBar(
          items: List.generate(
            _.pages.length,
            (index) => BottomNavigationBarItem(
              icon: Icon(
                AppPages.navigationScreensProperties[index]['icon'],
              ),
              label: AppPages.navigationScreensProperties[index]['label'],
            ),
          ),
        );
      },
    );
  }
}
