import 'package:get/get.dart';

import '/app/controller/initial/initial_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InitialController());
  }
}
