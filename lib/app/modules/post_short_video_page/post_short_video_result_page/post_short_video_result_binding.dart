import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/post_short_video_page/post_short_video_result_page/post_short_video_result_controller.dart';

class PostShortVideoResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PostShortVideoResultController());
  }
}
