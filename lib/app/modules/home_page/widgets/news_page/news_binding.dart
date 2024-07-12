import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/home_page/widgets/news_page/news_controller.dart';

class NewsBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(NewsController());
  }


}