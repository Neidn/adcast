import 'package:get/get.dart';

import '/app/controller/auth/login_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
