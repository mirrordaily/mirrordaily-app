import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/main_binding.dart';
import 'package:mirrordaily_app/routes/pages.dart';
import 'package:mirrordaily_app/routes/routes.dart';

class MirrorDailyApp extends StatelessWidget {
  const MirrorDailyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: Pages.pages,
      initialRoute: Routes.launchPage,
      initialBinding: MainBinding(),
    );
  }
}
