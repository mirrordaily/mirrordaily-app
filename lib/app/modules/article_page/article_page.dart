import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/enums/page_status.dart';
import 'package:mirrordaily_app/app/modules/article_page/article_controller.dart';
import 'package:mirrordaily_app/core/extensions/string_extension.dart';
import 'package:mirrordaily_app/core/theme/custom_color_theme.dart';
import 'package:mirrordaily_app/core/values/string.dart';

import 'widgets/people_widget.dart';

class ArticlePage extends GetView<ArticleController> {
  const ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Page'),
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          final pageStatus = controller.rxPageStatus.value;
          return pageStatus == PageStatus.normal
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          Text(
                              controller.article?.sectionList?[0].name ??
                                  StringDefault.nullString,
                              style: Get.textTheme.labelLarge?.copyWith(
                                  color: controller
                                      .article?.sectionList?[0].renderColor)),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            controller.article?.title ??
                                StringDefault.nullString,
                            textAlign: TextAlign.center,
                            style: Get.textTheme.headlineSmall?.copyWith(
                                color: CustomColorTheme.nature10,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            '更新時間 : ${controller.article?.updatedAt?.toFormattedYYYYMMDD()}',
                            style: Get.textTheme.labelMedium?.copyWith(
                                color: CustomColorTheme.natureVariant30),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          PeopleWidget(
                            title: '作者: ',
                            peopleList: controller.article?.writers ?? [],
                          ),
                          PeopleWidget(
                            title: '攝影: ',
                            peopleList: controller.article?.photographers ?? [],
                          ),
                          PeopleWidget(
                            title: '影音: ',
                            peopleList: controller.article?.cameraMan ?? [],
                          ),
                          PeopleWidget(
                            title: '設計: ',
                            peopleList: controller.article?.designers ?? [],
                          ),
                          PeopleWidget(
                            title: '工程: ',
                            peopleList: controller.article?.engineers ?? [],
                          ),
                          PeopleWidget(
                            title: '主播: ',
                            peopleList: controller.article?.vocals ?? [],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: controller.article!.tags!
                                .map((e) => Container(
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color: CustomColorTheme.secondary90,
                                      borderRadius:
                                          BorderRadius.circular(4), // 圆角半径
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Text(
                                      e.name ?? StringDefault.nullString,
                                      style: Get.textTheme.labelLarge?.copyWith(
                                          color:
                                              CustomColorTheme.natureVariant50),
                                    )))
                                .toList(),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                    controller.article?.heroImage?.resized?.w800 != null
                        ? Image.network(
                            controller.article!.heroImage!.resized!.w800!)
                        : const SizedBox.shrink(),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        controller.article?.heroCaption ??
                            StringDefault.nullString,
                        style: Get.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: CustomColorTheme.natureVariant50),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      color: CustomColorTheme.primary90,
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.article!.apiDataBrief!.length,
                        itemBuilder: (context, index) {
                          return controller.draftJsWidgetController.getWidget(
                              controller.article!.apiDataBrief![index]);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 12,
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.article!.apiData!.length,
                      itemBuilder: (context, index) {
                        return controller.draftJsWidgetController
                            .getWidget(controller.article!.apiData![index]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 32,
                        );
                      },
                    )
                  ],
                )
              : const SizedBox.shrink();
        }),
      ),
    );
  }
}
