import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/home_page/widgets/classfication_page/classification_controller.dart';

class ClassificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ClassificationController());
  }
}
