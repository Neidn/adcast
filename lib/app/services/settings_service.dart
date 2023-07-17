import 'package:get/get.dart';

import '../storage/device/device_id_storage.dart';

class SettingsService extends GetxService {
  void init() async {
    final String deviceId = await deviceIdStorage.getDeviceId();
    if (deviceId.isEmpty) {
      await deviceIdStorage.generateDeviceId();
    }
    print('$runtimeType delays 1 sec');
    await 1.delay();
    print('$runtimeType ready!');
  }
}
