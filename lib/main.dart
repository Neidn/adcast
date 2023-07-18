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
  debugPrint('starting services ...');

  await Get.putAsync(() => DbService().init());
  Get.put(SettingsService()).init();
  debugPrint('All services started...');
}

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await initServices(widgetsBinding);

  runApp(
    GetMaterialApp(
      textDirection: TextDirection.ltr,
      debugShowCheckedModeBanner: false,
      theme: appLightTheme,
      darkTheme: appDarkTheme,
      themeMode: ThemeMode.system,
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
