import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/spill_the_tea_page/spill_the_tea_controller.dart';

class SpillTheTeaBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SpillTheTeaController());
  }
}
