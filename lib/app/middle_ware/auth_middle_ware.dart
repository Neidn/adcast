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
    AuthService.to.loginCheck().then((value) {
      if (AuthService.to.authenticated ||
          route == Routes.login ||
          route == Routes.initial) {
        return null;
      } else {
        return const RouteSettings(name: Routes.login);
      }
    });

    return null;
  }
}
