import 'package:get/get.dart';

import '/app/storage/db/user_info_table.dart';
import '/app/utils/global_variables.dart';

class ProfileController extends GetxController {
  // UserName
  final RxString _userName = ''.obs;

  String get userName => _userName.value;

  set userName(String value) => _userName.value = value;

  // User Info Table
  UserInfoTable userInfoTable = UserInfoTable(appUserInfoTable);

  @override
  void onInit() async {
    userName = await userInfoTable.getUserName();
    super.onInit();
  }
}
