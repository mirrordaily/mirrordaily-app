import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/launch_page/launch_controller.dart';

class LaunchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LaunchController());
  }
}
