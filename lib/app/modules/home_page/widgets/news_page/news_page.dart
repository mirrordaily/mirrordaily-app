import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mirrordaily_app/app/modules/home_page/widgets/news_page/news_controller.dart';
import 'package:mirrordaily_app/core/values/lottie_path.dart';


class NewsPage extends GetView<NewsController> {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          final categoryList = controller.rxCategoryList.value;
          return TabBar(
              controller: controller.categoryTabController,
              tabs: categoryList
                  .map((e) => Tab(
                        text: e,
                      ))
                  .toList());
        }),
        Expanded(
          child: TabBarView(
              controller: controller.categoryTabController,
              children: controller.rxTabContentList),
        )

      ],
    );
  }
}
