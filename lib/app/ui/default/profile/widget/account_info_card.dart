import 'package:adcast/app/controller/main/main_controller.dart';
import 'package:adcast/app/data/model/user/user_info_data.dart';
import 'package:adcast/app/ui/theme/app_colors.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class AccountInfoCard extends StatelessWidget {
  final String userName;
  final UserInfoData userInfoData;

  const AccountInfoCard({
    super.key,
    required this.userName,
    required this.userInfoData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        color: MainController.to.isDarkMode ? secondaryColor : primaryColor,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        children: [
          // user info
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  (userName == '') ? '-' : userName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          const Divider(
            height: 0,
          ),

          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  '선택 상품',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  userInfoData.goods.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          const DottedLine(
            dashColor: Colors.white,
            dashGapLength: 5,
            dashRadius: 5,
            lineThickness: 1,
            dashLength: 5,
            lineLength: double.infinity,
          ),

          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  '잔여일',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  userInfoData.rDay.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
