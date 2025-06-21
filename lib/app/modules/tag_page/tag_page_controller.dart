import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/models/article_preview.dart';
import 'package:mirrordaily_app/app/data/providers/article_gql_provider.dart';

class TagPageController extends GetxController {
  final Rxn<ArticlePreview> rxnArticlePreview = Rxn();
  final RxnString rxnTagName = RxnString();
  final ArticleGqlProvider articleGqlProvider = Get.find();
  final RxList<ArticlePreview> rxArticleList = RxList();
  int page = 0;
  int oneTimeLoadArticleCount = 10;
  final RxBool rxIsAllArticle = false.obs;

  @override
  void onInit() async {
    super.onInit();
    rxnTagName.value = Get.arguments as String?;
    if (rxnTagName.value != null) {
      rxArticleList.value =
          await articleGqlProvider.getArticleListByTag(name: rxnTagName.value!);
    }
    if (rxArticleList.length < 10) {
      rxIsAllArticle.value = true;
    }
  }

  void fetchMoreArticleButtonClick() async {
    page++;
    final newArticleList = await articleGqlProvider.getArticleListByTag(
        name: rxnTagName.value!,
        take: oneTimeLoadArticleCount,
        skip: page * oneTimeLoadArticleCount);
    if (newArticleList.length < 10) {
      rxIsAllArticle.value = true;
    }
    rxArticleList.addAll(newArticleList);
  }
}
