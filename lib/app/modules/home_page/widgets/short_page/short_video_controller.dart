import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/home_page/widgets/tab_content.dart';
import 'package:mirrordaily_app/core/values/page_category/short_video_category.dart';

class ShortVideoController extends GetxController with GetTickerProviderStateMixin{
  final RxList<String> rxCategoryList = RxList();
  TabController? categoryTabController;
  final RxList<Widget> rxTabContentList = RxList();

  @override
  void onInit() {
    categoryTabController =
        TabController(length: ShortVideCategory.category.length, vsync: this);
    rxCategoryList.value = ShortVideCategory.category;
    rxTabContentList.value =
        ShortVideCategory.category.map((e) => TabContent(name: e)).toList();
  }
}