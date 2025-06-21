import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/post_short_video_page/post_short_controller.dart';

class PostShortVideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PostShortVideoController());
  }
}
