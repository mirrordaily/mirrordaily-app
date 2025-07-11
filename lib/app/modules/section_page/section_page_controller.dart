import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/models/article.dart';
import 'package:mirrordaily_app/app/data/models/article_preview.dart';
import 'package:mirrordaily_app/app/data/providers/article_api_provider.dart';
import 'package:mirrordaily_app/app/data/providers/article_gql_provider.dart';
import 'package:mirrordaily_app/app/data/providers/category_gql_provider.dart';
import 'package:mirrordaily_app/app/data/models/category_response.dart';
import 'package:mirrordaily_app/routes/routes.dart';

class SectionPageController extends GetxController {
  final Rxn<Section> rxnSection = Rxn();
  final ArticleApiProvider articleApiProvider = Get.find();
  final ArticleGqlProvider articleGqlProvider =Get.find();
  final CategoryGqlProvider categoryGqlProvider = Get.find();
  final RxList<Category> rxnCategoryList = RxList();
  final Rx<Category> rxSelectCategory = Rx(Category());
  final RxList<ArticlePreview> rxArticleList = RxList();
  int? totalCount;

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
    page = 0;
    rxArticleList.clear();
    totalCount = null;
    if (rxSelectCategory.value.slug == 'all') {
      final sectionResponse = await articleApiProvider.getArticleBySection(
        sectionName: rxnSection.value?.slug ?? '',
        page: 1,
      );
      rxArticleList.value = sectionResponse?.section?.items ?? [];
      final counts = sectionResponse?.section?.counts;
      totalCount = (counts?.posts ?? 0) + (counts?.externals ?? 0);
    } else {
      final categoryResponse = await articleApiProvider.getArticleByCategory(
        category: rxSelectCategory.value.slug ?? '',
        page: 1,
      );
      rxArticleList.value = categoryResponse?.category?.items ?? [];
      final counts = categoryResponse?.category?.counts;
      totalCount = (counts?.posts ?? 0) + (counts?.externals ?? 0);
    }
  }

  void fetchMoreButtonClick() async {
    page++;
    if (totalCount != null && rxArticleList.length >= totalCount!) {
      // 用 GQL 拿更多，改用 articleGqlProvider.getArticleBySectionSlugAndCategorySlug
      List<ArticlePreview> gqlList = await articleGqlProvider.getArticleBySectionSlugAndCategorySlug(
        slug: rxnSection.value?.slug,
        categorySlug: rxSelectCategory.value.slug == 'all' ? null : rxSelectCategory.value.slug,
        skip: rxArticleList.length,
        take: 10,
      );
      // 去除重複 id
      final existingIds = rxArticleList.map((e) => e.id).toSet();
      final uniqueList = gqlList.where((e) => !existingIds.contains(e.id)).toList();
      rxArticleList.addAll(uniqueList);
    } else {
      // 還沒超過API總數，繼續用API
      List<ArticlePreview> newArticleList = [];
      if (rxSelectCategory.value.slug == 'all') {
        final sectionResponse = await articleApiProvider.getArticleBySection(
          sectionName: rxnSection.value?.slug ?? '',
          page: page + 1,
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
  }

  void categorySelectEvent(Category category) async {
    page = 0;
    rxSelectCategory.value = category;
    await initArticleList();
  }

  void onArticleTap(ArticlePreview article) {
    if (article.type == 'external') {
      Get.toNamed(Routes.externalArticlePage, arguments: article.id);
    } else {
      Get.toNamed(Routes.articlePage, arguments: article.id);
    }
  }
}
