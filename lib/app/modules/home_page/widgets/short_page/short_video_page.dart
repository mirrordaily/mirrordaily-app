import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/home_page/widgets/short_page/short_video_controller.dart';


class ShortVideoPage extends GetView<ShortVideoController> {
  const ShortVideoPage({super.key});

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
