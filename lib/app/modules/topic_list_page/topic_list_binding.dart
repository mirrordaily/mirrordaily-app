import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/topic_list_page/topic_list_controller.dart';

class TopicListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TopicListController());
  }
}
