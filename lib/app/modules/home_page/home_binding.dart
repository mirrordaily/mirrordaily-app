import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/home_page/home_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(HomeController());
  }


}