import 'package:adcast/app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '/app/routes/app_pages.dart';

import '/app/translations/app_translations.dart';

import '/app/ui/theme/app_theme.dart';

import '/app/services/auth_service.dart';
import '/app/services/db_service.dart';
import '/app/services/settings_service.dart';

import 'app/storage/device/device_id_storage.dart';

Future<void> initServices(WidgetsBinding widgetsBinding) async {
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  print('starting services ...');

  await Get.putAsync(() => DbService().init());
  Get.put(SettingsService()).init();
  print('All services started...');
}

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await initServices(widgetsBinding);

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      defaultTransition: Transition.fade,
      initialRoute: Routes.main,
      initialBinding: BindingsBuilder(() {
        Get.put(DeviceIdStorage());
        Get.put(AuthService());
      }),
      getPages: AppPages.pages,
      locale: const Locale('ko', 'KR'),
      translationsKeys: AppTranslation.translations,
    ),
  );
}
