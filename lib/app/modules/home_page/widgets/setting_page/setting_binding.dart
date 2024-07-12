import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/home_page/widgets/setting_page/setting_controller.dart';


class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SettingController());
  }
}
