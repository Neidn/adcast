import 'package:get_storage/get_storage.dart';

import '/app/utils/global_variables.dart';

import '/app/utils/uuid.dart';

class DeviceIdStorage {
  final _box = GetStorage(appStorage);

  // Device ID
  String get deviceId => _box.read(deviceIdStorageKey) ?? '';

  set deviceId(String value) => _box.write(deviceIdStorageKey, value);

  Future<void> resetDeviceId() async {
    try {
      await _box.remove(deviceIdStorageKey);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> generateDeviceId() async {
    try {
      await resetDeviceId();
      deviceId = getDeviceId();
    } catch (e) {
      rethrow;
    }
  }
}

final deviceIdStorage = DeviceIdStorage();
