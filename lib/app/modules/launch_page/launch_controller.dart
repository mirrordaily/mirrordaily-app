import 'package:get/get.dart';
import 'package:mirrordaily_app/routes/routes.dart';

class LaunchController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(const Duration(seconds: 5), () async {
      Get.offAllNamed(Routes.homePage);
    });
  }
}
