import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/section_page/section_page_controller.dart';

class SectionPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SectionPageController());
  }
}
