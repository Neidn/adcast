import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../storage/device/device_id_storage.dart';

class SettingsService extends GetxService {
  void init() async {
    final String deviceId = await deviceIdStorage.getDeviceId();
    if (deviceId.isEmpty) {
      await deviceIdStorage.generateDeviceId();
    }
    debugPrint('$runtimeType delays 1 sec');
    await 1.delay();
    debugPrint('$runtimeType ready!');
  }
}
