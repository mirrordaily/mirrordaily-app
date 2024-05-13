import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/home_page/home_binding.dart';
import 'package:mirrordaily_app/app/modules/home_page/home_page.dart';
import 'package:mirrordaily_app/app/modules/launch_page/launch_binding.dart';
import 'package:mirrordaily_app/app/modules/launch_page/launch_page.dart';
import 'package:mirrordaily_app/routes/routes.dart';

class Pages {
  static final pages = [
    GetPage(
        name: Routes.launchPage,
        page: () => const LaunchPage(),
        binding: LaunchBinding()),
    GetPage(
        name: Routes.homePage,
        page: () => const HomePage(),
        binding: HomeBinding()),
  ];
}
