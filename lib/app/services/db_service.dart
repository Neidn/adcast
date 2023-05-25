import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '/app/utils/global_variables.dart';

import '/app/utils/db_helper.dart';

class DbService extends GetxService {
  Future<DbService> init() async {
    await getStorage();
    await DBHelper().init();

    print('$runtimeType delays 1 sec');
    await 1.delay();
    print('$runtimeType ready!');
    return this;
  }

  Future<void> getStorage() async {
    await GetStorage.init(appStorage);
  }
}
