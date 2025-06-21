import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/enums/page_status.dart';
import 'package:mirrordaily_app/app/modules/article_page/article_controller.dart';
import 'package:mirrordaily_app/app/modules/article_page/widgets/latest_popular_article_block.dart';
import 'package:mirrordaily_app/app/widgets/article_list_item.dart';
import 'package:mirrordaily_app/app/widgets/network_image_widget.dart';
import 'package:mirrordaily_app/core/extensions/string_extension.dart';
import 'package:mirrordaily_app/core/theme/custom_color_theme.dart';
import 'package:mirrordaily_app/core/values/string.dart';
import 'package:mirrordaily_app/routes/routes.dart';

import 'widgets/people_widget.dart';
import 'widgets/relate_article_item.dart';
import 'widgets/related_article_block.dart';

class ArticlePage extends GetView<ArticleController> {
  ArticlePage({super.key});

  final String id = Get.arguments;

  @override
  String? get tag => id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                          controller.article?.sectionList != null &&
                                  controller.article!.sectionList!.isNotEmpty
                              ? Text(
                                  controller.article?.sectionList?[0].name ??
                                      StringDefault.nullString,
                                  style: Get.textTheme.labelLarge?.copyWith(
                                      color: controller.article?.sectionList?[0]
                                          .renderColor))
                              : const SizedBox.shrink(),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            controller.article?.title ??
                                StringDefault.nullString,
                            textAlign: TextAlign.left,
                            style: Get.textTheme.headlineSmall?.copyWith(
                                color: CustomColorTheme.nature10,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              Text(
                                '${controller.article?.updatedAt?.toFormattedYYYYMMDD()}',
                                style: Get.textTheme.labelMedium?.copyWith(
                                    color: CustomColorTheme.natureVariant30),
                              ),
                            ],
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
                            title: '編輯: ',
                            peopleList: controller.article?.designers ?? [],
                          ),
                          PeopleWidget(
                            title: '主播: ',
                            peopleList: controller.article?.vocals ?? [],
                          ),
                          PeopleWidget(
                            title: '總主筆: ',
                            peopleList: controller.article?.engineers ?? [],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Wrap(
                            alignment: WrapAlignment.start,
                            spacing: 8,
                            runSpacing: 8,
                            children: controller.article!.combinedTags
                                .map((e) => InkWell(
                                      onTap: () {
                                        Get.toNamed(Routes.tagPage,
                                            arguments: e.name);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: CustomColorTheme.secondary90,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 6),
                                        child: Text(
                                          e.name ?? StringDefault.nullString,
                                          style: Get.textTheme.labelLarge
                                              ?.copyWith(
                                            color: CustomColorTheme
                                                .natureVariant50,
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                    controller.article?.heroImage?.resized?.w800 != null
                        ? NetworkImageWidget(
                            url: controller.article!.heroImage!.resized!.w800!,
                          )
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
                    controller.article!.isApiDataBriefBlank != true
                        ? Container(
                            color: CustomColorTheme.primary90,
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  controller.article!.apiDataBrief!.length,
                              itemBuilder: (context, index) {
                                return controller.draftJsWidgetController
                                    .getWidget(controller
                                        .article!.apiDataBrief![index]);
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  height: 12,
                                );
                              },
                            ),
                          )
                        : const SizedBox.shrink(),
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
                    ),
                    ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.article!.warningList!.length,
                      itemBuilder: (context, index) {
                        String? content =
                            controller.article!.warningList?[index]['content'];
                        return Text(
                          '* $content',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: CustomColorTheme.secondary20),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 32,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    RelatedArticleBlock(
                      articleList: controller.article?.orderedRelateds,
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 60, horizontal: 32),
                      child: Divider(),
                    ),
                    LatestPopularArticleBlock(
                        articleList: controller.rxLatestArticleList.value),
                    const SizedBox(
                      height: 60,
                    ),
                    LatestPopularArticleBlock(
                      articleList: controller.rxPopularArticleList.value,
                      isLatest: false,
                    ),
                  ],
                )
              : const SizedBox.shrink();
        }),
      ),
    );
  }
}
