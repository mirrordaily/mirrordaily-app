import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/post_short_video_page/post_short_video_user_check_page/post_short_video_user_check_controller.dart';

class PostShortVideoUserCheckBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PostShortVideoUserCheckController());
  }
}
