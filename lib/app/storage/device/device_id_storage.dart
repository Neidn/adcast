import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:adcast/app/utils/global_variables.dart';
import 'package:adcast/app/utils/uuid.dart' as uuid;

class DeviceIdStorage {
  final _storage = FlutterSecureStorage(
    aOptions: getAndroidOptions(),
    iOptions: getIOSOptions(),
  );

  // Device ID
  /*
  final _box = GetStorage(appStorage);
  String get deviceId => _box.read(deviceIdStorageKey) ?? '';
  set deviceId(String value) => _box.write(deviceIdStorageKey, value);
   */

  Future<String> getDeviceId() async {
    return await _storage.read(key: deviceIdStorageKey) ?? '';
  }

  void setDeviceId(String value) async {
    await _storage.write(key: deviceIdStorageKey, value: value);
  }

  Future<void> resetDeviceId() async {
    try {
      // await _box.remove(deviceIdStorageKey);
      await _storage.delete(key: deviceIdStorageKey);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> generateDeviceId() async {
    try {
      await resetDeviceId();
      final String newDeviceId = uuid.getDeviceId();
      setDeviceId(newDeviceId);
    } catch (e) {
      rethrow;
    }
  }
}

final deviceIdStorage = DeviceIdStorage();
