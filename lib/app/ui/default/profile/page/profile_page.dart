import 'package:adcast/app/data/model/user/user_api_data.dart';
import 'package:adcast/app/ui/default/profile/widget/account_info_card.dart';
import 'package:adcast/app/ui/default/profile/widget/bid_count_pie_chart.dart';
import 'package:adcast/app/ui/default/profile/widget/logout_button.dart';
import 'package:dotted_line/dotted_line.dart';
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
                  MainController.to.isDarkMode
                      ? Icons.wb_sunny
                      : Icons.nightlight_round,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                _.isLoading
                    ? const LinearProgressIndicator()
                    : const Padding(padding: EdgeInsets.only(top: 0)),
                const Divider(),

                AccountInfoCard(
                  userName: userName,
                  userInfoData: _.userInfoData,
                ),

                // Using Keyword Count Card
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: BidCountPieChart(
                    title: '키워드 내역',
                    maxBidData: _.maxBidData,
                    bidData: _.bidData,
                  ),
                ),

                // BizMoney Per UserApi Card
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: List.generate(
                      _.userApiDataList.length,
                      (index) {
                        final UserApiData userApiData =
                            _.userApiDataList[index];

                        return Column(
                          children: [
                            if (index != 0)
                              const DottedLine(
                                dashGapLength: 5,
                                dashRadius: 5,
                                lineThickness: 1,
                                dashLength: 5,
                                lineLength: double.infinity,
                              ),
                            ListTile(
                              title: Text(
                                userApiData.customerName ?? '',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Text(
                                '${userApiData.bizmoney ?? 0} 원',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),

                // Logout Button
                LogoutButton(
                  logOut: logOut,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
