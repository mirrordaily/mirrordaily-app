import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/models/article.dart';
import 'package:mirrordaily_app/app/data/providers/article_gql_provider.dart';
import 'package:mirrordaily_app/app/data/providers/category_gql_provider.dart';

class SectionPageController extends GetxController {
  final Rxn<Section> rxnSection = Rxn();
  final ArticleGqlProvider articleApiProvider = Get.find();
  final CategoryGqlProvider categoryGqlProvider = Get.find();
  final RxList<Category> rxnCategoryList = RxList();
  final Rx<Category> rxSelectCategory = Rx(Category());
  final RxList<Article> rxArticleList = RxList();

  int page = 0;

  Color? sectionColor;

  @override
  void onInit() async {
    super.onInit();
    rxnSection.value = Get.arguments;
    sectionColor = rxnSection.value?.renderColor;
    if (rxnSection.value?.slug != null) {
      rxnCategoryList.value = await categoryGqlProvider
          .getCategoryBySectionSlug(slug: rxnSection.value!.slug!);
      rxnCategoryList.insert(
        0,
        Category(id: 'all', name: '全部', slug: 'all'),
      );
      if (rxnCategoryList.isNotEmpty) {
        rxSelectCategory.value = rxnCategoryList.first;
      }
    }
    initArticleList();
  }

  Future<void> initArticleList() async {
    rxArticleList.value =
        await articleApiProvider.getArticleBySectionSlugAndCategorySlug(
            slug: rxnSection.value?.slug,
            categorySlug: rxSelectCategory.value.slug);
  }

  void fetchMoreButtonClick() async {
    page++;
    final newArticleList =
        await articleApiProvider.getArticleBySectionSlugAndCategorySlug(
            slug: rxnSection.value?.slug,
            categorySlug: rxSelectCategory.value.slug,
            skip: page * 10);
    rxArticleList.addAll(newArticleList);
  }

  void categorySelectEvent(Category category) async {
    page = 0;
    rxSelectCategory.value = category;
    await initArticleList();
  }
}
