import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/models/article_preview.dart';
import 'package:mirrordaily_app/app/data/models/external_article.dart';
import 'package:mirrordaily_app/app/data/providers/article_api_provider.dart';
import 'package:mirrordaily_app/app/data/providers/article_gql_provider.dart';

class ExternalArticleController extends GetxController {
  final ArticleGqlProvider articleGqlProvider = Get.find();
  final String id;

  ExternalArticleController(this.id);

  final Rxn<ExternalArticle> rxnExternalArticle = Rxn();
  final ArticleApiProvider articleApiProvider = Get.find();
  final RxList<ArticlePreview> rxLatestArticleList = RxList();
  final RxList<ArticlePreview> rxPopularArticleList = RxList();

  @override
  void onInit() async {
    super.onInit();
    rxnExternalArticle.value =
        await articleGqlProvider.getExternalArticleById(id: id);
    if (rxnExternalArticle.value == null) {
      Get.back();
      return;
    }
    rxLatestArticleList.value =
        (await articleApiProvider.getLatestArticles()).take(6).toList();
    rxPopularArticleList.value =
        (await articleApiProvider.getPopularArticles()).take(6).toList();

  }
}
