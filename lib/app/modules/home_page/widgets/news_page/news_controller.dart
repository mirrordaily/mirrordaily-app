import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/providers/article_api_provider.dart';
import 'package:mirrordaily_app/app/modules/home_page/widgets/tab_content.dart';
import 'package:mirrordaily_app/core/values/page_category/home_category.dart';

class NewsController extends GetxController with GetTickerProviderStateMixin {
  final RxList<String> rxCategoryList = RxList();
  TabController? categoryTabController;
  final RxList<Widget> rxTabContentList = RxList();
  final ArticleApiProvider articleApiProvider = Get.find();

  @override
  void onInit() {
    super.onInit();
    categoryTabController =
        TabController(length: HomeCategory.category.length, vsync: this);
    rxCategoryList.value = HomeCategory.category;
    rxTabContentList.value =
        HomeCategory.category.map((e) => TabContent(name: e)).toList();
  }

  void test() async {
    final result =await articleApiProvider.getSectionList();
    print(result.length);
  }
}
