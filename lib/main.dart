import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get_storage/get_storage.dart';

import 'core/bindings/app_bindings.dart';
import 'core/constants/app_colors.dart';
import 'core/services/api/services/api_services.dart';
import 'core/themes/themes.dart';
import 'core/util/app_navigation.dart';
import 'core/util/storage_service.dart';
import 'features/auth/views/sign_in_screen.dart';
import 'features/base/views/base_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final baseUrl = !kIsWeb && Platform.isAndroid
  //     ? "http://10.0.2.2:8000/api"
  //     : "http://127.0.0.1:8000/api";
  Get.put(ApiServices(baseUrl: "baseUrl"));
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  await GetStorage.init();
  AppBindings.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Averymarsh',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      navigatorKey: AppNavigation.navigatorKey,
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 280),
      home: StorageService.hasToken
          ? const BasePage()
          : const SignInScreen(),
    );
  }
}
