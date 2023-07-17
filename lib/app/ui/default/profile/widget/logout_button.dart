import 'package:adcast/app/controller/main/main_controller.dart';
import 'package:adcast/app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback logOut;

  const LogoutButton({
    super.key,
    required this.logOut,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => logOut(),
        style: ElevatedButton.styleFrom(
          backgroundColor: MainController.to.isDarkMode
              ? logoutDarkBackgroundColor
              : logoutLightBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Logout',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
