import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_whiz/bindings/app_binding.dart';

import 'pages/home_screen.dart';
import 'config/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Manually initialize bindings
  AppBindings().dependencies();

  runApp(MyApp());
}

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  ThemeData get currentTheme => isDarkMode.value ? AppTheme.darkTheme : AppTheme.lightTheme;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Weather App",
          theme: themeController.currentTheme,
          initialBinding: AppBindings(),
          home: HomeScreen(),
        ));
  }
}