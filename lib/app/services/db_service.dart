import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '/app/utils/global_variables.dart';

import '/app/storage/campaign/group_list_data_storage.dart';
import '/app/storage/keyword/keyword_list_data_storage.dart';

class DbService extends GetxService {
  Future<DbService> init() async {
    await GetStorage.init(appStorage);

    await groupListDataStorage.resetGroupListData();
    await keywordListDataStorage.resetKeywordListData();
    print('$runtimeType delays 1 sec');
    await 1.delay();
    print('$runtimeType ready!');
    return this;
  }
}
