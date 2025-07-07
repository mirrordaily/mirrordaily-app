import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/models/article.dart';
import 'package:mirrordaily_app/app/data/models/article_preview.dart';
import 'package:mirrordaily_app/app/data/providers/article_api_provider.dart';
import 'package:mirrordaily_app/app/data/providers/article_gql_provider.dart';
import 'package:mirrordaily_app/app/data/providers/category_gql_provider.dart';
import 'package:mirrordaily_app/app/data/models/category_response.dart';

class SectionPageController extends GetxController {
  final Rxn<Section> rxnSection = Rxn();
  final ArticleApiProvider articleApiProvider = Get.find();
  final CategoryGqlProvider categoryGqlProvider = Get.find();
  final RxList<Category> rxnCategoryList = RxList();
  final Rx<Category> rxSelectCategory = Rx(Category());
  final RxList<ArticlePreview> rxArticleList = RxList();
  final RxBool rxIsAllArticle = false.obs;

  int page = 0;

  Color? sectionColor;

  @override
  void onInit() async {
    super.onInit();
    rxnSection.value = Get.arguments;
    sectionColor = rxnSection.value?.renderColor;
    rxnCategoryList.clear();
    
    if (rxnSection.value?.categories != null) {
      rxnCategoryList.add(
        Category(id: 'all', name: '全部', slug: 'all'),
      );
      final originalCategories = rxnSection.value!.categories!;
      for (var category in originalCategories) {
        rxnCategoryList.add(
          Category(
            id: category.id,
            name: category.name,
            slug: category.slug,
          ),
        );
      }
      
      if (rxnCategoryList.isNotEmpty) {
        rxSelectCategory.value = rxnCategoryList.first;
      }
    }
    initArticleList();
  }

  Future<void> initArticleList() async {
    if (rxSelectCategory.value.slug == 'all') {
      final sectionResponse = await articleApiProvider.getArticleBySection(
        sectionName: rxnSection.value?.slug ?? '',
        page: 1,
      );
      rxArticleList.value = sectionResponse?.section?.items ?? [];
      if ((sectionResponse?.section?.items?.length ?? 0) < 10) {
        rxIsAllArticle.value = true;
      } else {
        rxIsAllArticle.value = false;
      }
    } else {
      final categoryResponse = await articleApiProvider.getArticleByCategory(
        category: rxSelectCategory.value.slug ?? '',
        page: 1,
      );
      rxArticleList.value = categoryResponse?.category?.items ?? [];
      if ((categoryResponse?.category?.items?.length ?? 0) < 10) {
        rxIsAllArticle.value = true;
      } else {
        rxIsAllArticle.value = false;
      }
    }
  }

  void fetchMoreButtonClick() async {
    if (rxIsAllArticle.value == true) return;
    page++;
    List<ArticlePreview> newArticleList = [];

    if (rxSelectCategory.value.slug == 'all') {
      final sectionResponse = await articleApiProvider.getArticleBySection(
        sectionName: rxnSection.value?.slug ?? '',
        page: page + 1, // page 從 1 開始
      );
      newArticleList = sectionResponse?.section?.items ?? [];
    } else {
      final categoryResponse = await articleApiProvider.getArticleByCategory(
        category: rxSelectCategory.value.slug ?? '',
        page: page + 1,
      );
      newArticleList = categoryResponse?.category?.items ?? [];
    }

    rxArticleList.addAll(newArticleList);
  }

  void categorySelectEvent(Category category) async {
    page = 0;
    rxSelectCategory.value = category;
    await initArticleList();
  }
}
