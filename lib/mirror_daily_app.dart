import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/core/theme/custom_text_style.dart';
import 'package:mirrordaily_app/main_binding.dart';
import 'package:mirrordaily_app/routes/pages.dart';
import 'package:mirrordaily_app/routes/routes.dart';

import 'routes/custom_router_observer.dart';

class MirrorDailyApp extends StatelessWidget {
  const MirrorDailyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorObservers: [CustomRouterObserver.routeObserver],
      theme: ThemeData.light().copyWith(
        textTheme: CustomTextStyle.defaultTextTheme,
        bottomNavigationBarTheme: BottomNavigationBarTheme.of(context).copyWith(
          unselectedItemColor: Colors.red,
          selectedItemColor: Colors.blue,
          backgroundColor: Colors.red,
        ),
      ),
      getPages: Pages.pages,
      initialRoute: Routes.launchPage,
      initialBinding: MainBinding(),
    );
  }
}
