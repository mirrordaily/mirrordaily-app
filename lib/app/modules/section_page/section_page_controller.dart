import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/models/article.dart';
import 'package:mirrordaily_app/app/data/providers/article_gql_provider.dart';

class SectionPageController extends GetxController {
  final Rxn<Section> rxnSection = Rxn();
  final ArticleGqlProvider articleApiProvider = Get.find();
  final RxList<Category> rxnCategoryList = RxList();
  final Rx<Category> rxSelectCategory = Rx(Category());
  final RxList<Article> rxArticleList = RxList();

  Color? sectionColor;

  @override
  void onInit() async {

    super.onInit();
    rxnSection.value = Get.arguments;
    sectionColor = rxnSection.value?.renderColor;
    if (rxnSection.value?.slug != null) {
      rxnCategoryList.value = await articleApiProvider.getCategoryBySectionSlug(
          slug: rxnSection.value!.slug!);
      if (rxnCategoryList.isNotEmpty) {
        rxSelectCategory.value = rxnCategoryList.first;
      }
      rxArticleList.value = await articleApiProvider.getArticleBySectionSlug(
          slug: rxnSection.value?.slug);

    }

  }

  void categorySelectEvent(Category category) {
    rxSelectCategory.value = category;
  }
}
