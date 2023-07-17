import 'package:flutter/material.dart';

import '/app/controller/main/main_controller.dart';
import '/app/ui/theme/app_colors.dart';
import '/app/ui/default/widgets/default_logo_widget.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const DefaultLogoWidget(),
        centerTitle: false,
        backgroundColor: MainController.to.isDarkMode
            ? mobileDarkBackGroundColor
            : mobileLightBackGroundColor,
      ),
      body: const Column(
        children: [
          Divider(),
          Center(child: Text('Second Page')),
        ],
      ),
    );
  }
}
