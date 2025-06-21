import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/home_page/widgets/short_page/short_video_controller.dart';


class ShortVideoBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ShortVideoController());
  }

}