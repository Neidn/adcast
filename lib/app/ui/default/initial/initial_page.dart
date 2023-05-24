import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/controller/initial/initial_controller.dart';

class InitialPage extends GetView<InitialController> {
  const InitialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Initial Page'),
      ),
    );
  }
}
