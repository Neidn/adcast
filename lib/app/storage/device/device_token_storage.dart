import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:adcast/app/utils/global_variables.dart';

class DeviceTokenStorage {
  final _storage = FlutterSecureStorage(
    aOptions: getAndroidOptions(),
    iOptions: getIOSOptions(),
  );

  // Device Token
  Future<String> getDeviceToken() async {
    return await _storage.read(key: deviceTokenStorageKey) ?? '';
  }

  void setDeviceToken(String value) async {
    await _storage.write(key: deviceTokenStorageKey, value: value);
  }

  Future<void> resetDeviceToken() async {
    try {
      await _storage.delete(key: deviceTokenStorageKey);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> emptyDeviceTokenCheck() async {
    final String deviceToken = await deviceTokenStorage.getDeviceToken();
    try {
      if (deviceToken == '' || deviceToken.isEmpty == true) {
        return true;
      }
    } catch (e) {
      // await resetDeviceToken();
      return false;
    }
    return false;
  }
}

final deviceTokenStorage = DeviceTokenStorage();
