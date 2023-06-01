import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_social_media/config/config.dart';

import 'package:simple_social_media/routes/routes.dart';
import 'package:simple_social_media/utils/theme_controller.dart';


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    ThemeController themeController = Get.put(ThemeController());
    return ScreenUtilInit(
      designSize: const Size(360,690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: StringsAssets.appTitle,
          theme: themeController.themeData(ThemeConfig.lightTheme),
          darkTheme: themeController.themeData(ThemeConfig.darkTheme),
          themeMode: ThemeMode.system,
          initialRoute: Routes.root,
          getPages: routes,
        );
      },
    );
  }
}
  