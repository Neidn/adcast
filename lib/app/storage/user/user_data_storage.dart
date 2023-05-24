import 'package:get_storage/get_storage.dart';

import '/app/utils/global_variables.dart';

import '/app/data/model/user/user_data.dart';

class UserDataStorage {
  final _box = GetStorage(appStorage);

  // User Data
  UserData get userData {
    try {
      return UserData.fromJson(_box.read(userDataStorageKey) ?? {});
    } catch (e) {
      resetUserData();
      return UserData.fromJson({});
    }
  }

  set userData(UserData value) =>
      _box.write(userDataStorageKey, value.toJson());

  Future<void> resetUserData() async {
    try {
      await _box.remove(userDataStorageKey);
    } catch (e) {
      rethrow;
    }
  }

  bool emptyUserDataCheck() {
    try {
      if (userDataStorage.userData.userid == '' ||
          userDataStorage.userData.userid == null ||
          userDataStorage.userData.userid?.isEmpty == true ||
          userDataStorage.userData.username == '' ||
          userDataStorage.userData.username == null ||
          userDataStorage.userData.username?.isEmpty == true) {
        return true;
      }
    } catch (e) {
      resetUserData();
      return true;
    }
    return false;
  }
}

final userDataStorage = UserDataStorage();
