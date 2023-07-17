import 'package:get/get.dart';

import 'package:adcast/app/utils/db_helper.dart';

class DbService extends GetxService {
  Future<DbService> init() async {
    await DBHelper().init();

    print('$runtimeType delays 1 sec');
    await 1.delay();
    print('$runtimeType ready!');
    return this;
  }
}
