import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/article_page/article_controller.dart';
import 'package:mirrordaily_app/app/widgets/draft_js_widget_factory/draft_js_widget_controller.dart';

class ArticleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DraftJsWidgetController());
    Get.put(ArticleController());

  }
}
