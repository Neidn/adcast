import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/controller/device/device_token_controller.dart';

import '/app/services/auth_service.dart';
import '/app/storage/user/user_data_storage.dart';

class ProfilePage extends GetView<DeviceTokenController> {
  const ProfilePage({super.key});

  Future<void> logOut() async {
    var response = await Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey,
        title: const Text(
          'Logout',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text(
              'Logout',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );

    if (response == true) {
      await AuthService().logout();
    }
  }

  Widget _userInfoItemProfile(IconData iconData, String userData) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 30,
            color: Colors.black,
          ),
          const SizedBox(width: 16),
          Text(
            userData,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  void sessionCheckTest() {
    controller.sessionDeviceToken();
  }

  @override
  Widget build(BuildContext context) {
    String userName = userDataStorage.userData.username ?? '';

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        children: [
          const SizedBox(height: 20),
          _userInfoItemProfile(Icons.person, userName),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => sessionCheckTest(),
            child: const Text('Test'),
          ),
          const SizedBox(height: 20),
          Center(
            child: Material(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: () async => await logOut(),
                borderRadius: BorderRadius.circular(32),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
