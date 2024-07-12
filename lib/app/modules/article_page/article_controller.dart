import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/enums/page_status.dart';
import 'package:mirrordaily_app/app/data/models/article.dart';
import 'package:mirrordaily_app/app/data/providers/article_api_provider.dart';
import 'package:mirrordaily_app/app/widgets/draft_js_widget_factory/draft_js_widget_controller.dart';

class ArticleController extends GetxController {
  final ArticleApiProvider articleApiProvider = Get.find();
  final DraftJsWidgetController draftJsWidgetController = Get.find();
  final Rx<PageStatus> rxPageStatus = PageStatus.normal.obs;
  Article? article;

  @override
  void onInit() async {
    super.onInit();
    rxPageStatus.value = PageStatus.loading;
    article =
        await articleApiProvider.getArticleBySlug(slug: 'apptest20240703');
    rxPageStatus.value = PageStatus.normal;
  }
}
