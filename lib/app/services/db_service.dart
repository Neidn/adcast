import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:adcast/app/utils/db_helper.dart';

class DbService extends GetxService {
  Future<DbService> init() async {
    await DBHelper().init();

    debugPrint('$runtimeType delays 1 sec');
    await 1.delay();
    debugPrint('$runtimeType ready!');
    return this;
  }
}
