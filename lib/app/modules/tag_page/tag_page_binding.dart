import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/tag_page/tag_page_controller.dart';

class TagPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TagPageController());
  }
}
