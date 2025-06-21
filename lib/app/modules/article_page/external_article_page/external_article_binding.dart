import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/article_page/external_article_page/external_article_controller.dart';

class ExternalArticleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ExternalArticleController(Get.arguments), tag: '${Get.arguments}');
  }
}
