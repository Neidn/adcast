import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/routes/app_pages.dart';

import '/app/services/auth_service.dart';

class AuthMiddleWare extends GetMiddleware {
  int? _priority = 1;

  @override
  int? get priority => _priority;

  @override
  set priority(int? value) => _priority = value;

  @override
  RouteSettings? redirect(String? route) {
    final AuthService authService = Get.find<AuthService>();
    authService.loginCheck();

    if (authService.authenticated ||
        route == Routes.login ||
        route == Routes.initial) {
      return null;
    } else {
      Future.delayed(const Duration(seconds: 1),
          () => Get.snackbar("Warning", "You must login"));
      return const RouteSettings(name: Routes.login);
    }
  }
}
