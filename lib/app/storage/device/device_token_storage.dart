import 'package:get_storage/get_storage.dart';

import '/app/utils/global_variables.dart';

class DeviceTokenStorage {
  final _box = GetStorage(appStorage);

  // Device Token
  String get deviceToken => _box.read(deviceTokenStorageKey) ?? '';

  set deviceToken(String value) => _box.write(deviceTokenStorageKey, value);

  Future<void> resetDeviceToken() async {
    try {
      await _box.remove(deviceTokenStorageKey);
    } catch (e) {
      rethrow;
    }
  }

  bool emptyDeviceTokenCheck() {
    try {
      if (deviceTokenStorage.deviceToken == '' ||
          deviceTokenStorage.deviceToken.isEmpty == true) {
        return true;
      }
    } catch (e) {
      resetDeviceToken();
      return true;
    }
    return false;
  }
}

final deviceTokenStorage = DeviceTokenStorage();
