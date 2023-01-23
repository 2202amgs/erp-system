import 'package:flutter/material.dart';
import 'package:frontend/app/config/routes/routes_config.dart';
import 'package:frontend/app/config/themes/custom_themes.dart';
import 'package:frontend/app/core/constants/app_routes.dart';
import 'package:frontend/app/core/services/app_services.dart';
import 'package:get/get_navigation/get_navigation.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'شركة النقل و التجارة',
      textDirection: TextDirection.rtl,
      locale: const Locale('ar'),
      themeMode: ThemeMode.dark,
      darkTheme: CustomThemes().dark(),
      theme: CustomThemes().light(),
      initialBinding: AppBinding(),
      initialRoute: AppRoutes.login,
      getPages: pages,
    );
  }
}
