import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/providers/article_gql_provider.dart';
import 'package:mirrordaily_app/app/modules/topic_page/topic_page_controller.dart';

class TopicPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ArticleGqlProvider());
    Get.put(TopicPageController());
  }
}
