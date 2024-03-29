import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/routes/app_pages.dart';

class MainController extends GetxController {
  static MainController get to => Get.find();

  // index
  final RxInt _currentIndex = 0.obs;

  int get currentIndex => _currentIndex.value;

  set currentIndex(int value) => _currentIndex.value = value;

  // page controller
  final PageController _pageController = PageController(initialPage: 0);

  PageController get pageController => _pageController;

  set pageController(PageController value) => _pageController;

  // Bid Exception Flag
  final RxBool _isBidException = true.obs;

  bool get isBidException => _isBidException.value;

  set isBidException(bool value) => _isBidException.value = value;

  // dark mode
  final RxBool _isDarkMode = false.obs;

  bool get isDarkMode => _isDarkMode.value;

  set isDarkMode(bool value) => _isDarkMode.value = value;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void changePage(int index) async {
    currentIndex = index;
    pageController.jumpToPage(index);
  }

  List<StatelessWidget> pages = List.generate(
    AppPages.navigationScreensProperties.length,
    (index) => AppPages.navigationScreensProperties[index]['page'],
  );

  void animateToPage(int index) {
    currentIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
