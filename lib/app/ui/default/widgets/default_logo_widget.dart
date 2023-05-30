import 'package:flutter/material.dart';

class DefaultLogoWidget extends StatelessWidget {
  const DefaultLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      width: 100,
    );
  }
}
