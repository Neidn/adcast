import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/ui/default/widgets/default_logo_widget.dart';
import '/app/ui/theme/app_colors.dart';

import 'package:adcast/app/controller/main/main_controller.dart';
import '/app/controller/profile/profile_controller.dart';

import '/app/services/auth_service.dart';

class ProfilePage extends GetView<ProfileController> {
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
      await AuthService.to.logout();
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

  @override
  Widget build(BuildContext context) {
    return GetX<ProfileController>(
      builder: (_) {
        final String userName = _.userInfoData.userName ?? '';
        return Scaffold(
          appBar: AppBar(
            title: const DefaultLogoWidget(),
            centerTitle: false,
            backgroundColor: MainController.to.isDarkMode
                ? mobileDarkBackGroundColor
                : mobileLightBackGroundColor,
            actions: [
              // change theme button
              IconButton(
                onPressed: () => _.toggleThemeMode(),
                icon: Icon(
                  MainController.to.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              _.isLoading
                  ? const LinearProgressIndicator()
                  : const Padding(padding: EdgeInsets.only(top: 0)),
              const Divider(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  children: [
                    const SizedBox(height: 8),
                    _userInfoItemProfile(Icons.person, userName),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      verticalDirection: VerticalDirection.down,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Column(
                            children: [
                              Text(
                                '${_.campaignCount}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const Text('캠페인'),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Column(
                            children: [
                              Text(
                                '${_.groupCount}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const Text('그룹'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
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
              ),
            ],
          ),
        );
      },
    );
  }
}
